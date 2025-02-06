import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../register/register_screen.dart';
import '../verification_screen.dart';

class LoginFormScreen extends StatefulWidget {
  final String role;

  LoginFormScreen({required this.role});

  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool _isButtonEnabled = false;

  void _updateMobileNumber(String number) {
    setState(() {
      _isButtonEnabled = _isValidPhoneNumber(number);
    });
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 11 && phoneNumber.startsWith('03') && RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
  }

  void _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = "+92${mobileController.text.trim()}"; // Pakistan country code

      setState(() {
        isLoading = true;
      });

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationScreen(verificationId: 'null',)),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Verification failed")));
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login as ${widget.role}",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              "Enter Your Mobile Number",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "We'll send you an OTP for verification.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Mobile Number *", mobileController, TextInputType.phone, isRequired: true),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _sendOTP : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled ? Colors.brown : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  "Don’t have an account? Register",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType phone,
      {TextInputType inputType = TextInputType.text, bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: isRequired
          ? (value) => value!.isEmpty ? "$label is required" : null
          : null,
      onChanged: _updateMobileNumber,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
      ),
    );
  }
}
