import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2/views/lawyer%20screens/lawyer_home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../client screens/client_home_screen.dart';
import '../register/register_screen.dart';
import '../verification_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


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
            MaterialPageRoute(builder: (context) => VerificationScreen(verificationId: 'null',role: widget.role)),
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
              builder: (context) => VerificationScreen(verificationId: verificationId,role: widget.role,),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null; // The user canceled the sign-in process
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );




      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Google sign-in error: ${e.toString()}");
      return null;
    }
  }
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print("Facebook sign-in error: $e");
      return null;
    }
    return null;
  }
  void handleLogin(UserCredential? userCredential) {
    if (userCredential != null) {
      if(widget.role.substring(0,2) == "lL"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LawyerHomeScreen(),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientHomeScreen(),
          ),
        );
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Please try again.")),
      );
    }
  }
  Future<void> handleGoogleSignIn() async {
    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential == null) {
      print("Google sign-in failed");
      return; // Stop execution if sign-in fails
    }
    handleLogin(userCredential);
  }

  Future<void> handleFacebookSignIn() async {
    UserCredential? userCredential = await signInWithFacebook();
    handleLogin(userCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login as ${widget.role.substring(1)}",
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

            SizedBox(height: 20),
            Center(child: Text("Or",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100))),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton("Google", "assets/images/google.png", handleGoogleSignIn),
                SizedBox(width: 20),
                _buildSocialButton("Facebook", "assets/images/facebook.png", handleFacebookSignIn),
              ],
            ),

            SizedBox(height: 40),

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

Widget _buildSocialButton(String text, String assetPath, Function onTap) {
  return Expanded(
    child: ElevatedButton.icon(
      onPressed: () => onTap(),
      icon: Image.asset(assetPath, width: 24, height: 24),
      label: Text(text, style: TextStyle(fontSize: 16, color: Colors.brown)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.brown, width: 2),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
      ),
    ),
  );
}

