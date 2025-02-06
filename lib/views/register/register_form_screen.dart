import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2/views/home_screen.dart';
import '../login/login_screen.dart';
import '../verification_screen.dart';

class RegisterFormScreen extends StatefulWidget {
  final String role;

  RegisterFormScreen({required this.role});

  @override
  _RegisterFormScreenState createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  void _sendOTP() async {
    try {
      if (_formKey.currentState!.validate()) {
        String phoneNumber = "+92${mobileController.text.trim()}";

        setState(() {
          isLoading = true;
        });

        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            print("Verification completed automatically.");
          },
          verificationFailed: (FirebaseAuthException e) {
            print("Error: ${e.code} - ${e.message}");
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.message ?? "Verification failed"))
            );
            setState(() {
              isLoading = false;
            });
          },
          codeSent: (String verificationId, int? resendToken) {
            print("Code sent! Verification ID: $verificationId");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("Auto retrieval timeout: $verificationId");
          },
        );
      }
    } catch (e) {
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected error occurred. Please try again."))
      );
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi, ${widget.role}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown.shade700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField("First Name", firstNameController,TextInputType.text, isRequired: true),
                    SizedBox(height: 20),
                    _buildTextField("Last Name", lastNameController,TextInputType.text, isRequired: true),
                    SizedBox(height: 20),
                    _buildTextField("Email (Optional)", emailController, TextInputType.emailAddress),
                    SizedBox(height: 20),
                    _buildTextField("Mobile Number *", mobileController, TextInputType.phone, isRequired: true),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _sendOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.shade600,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown.shade700),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType emailAddress,
      {TextInputType inputType = TextInputType.text, bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: isRequired
          ? (value) => value!.isEmpty ? "$label is required" : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
      ),
    );
  }

}
