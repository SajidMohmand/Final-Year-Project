import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fyp2/views/lawyer%20screens/lawyer_home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../client screens/client_home_screen.dart';
import '../lawyer screens/profileSetup/setup_profile_screen.dart';
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
                builder: (context) => VerificationScreen(verificationId: verificationId,role: widget.role,),
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
      if(widget.role.substring(0,2) == "rL"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSetupScreen(),
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
          "Hi, ${widget.role.substring(1)}",
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

                    SizedBox(height: 20),
                    Text("Or",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100),),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton("Google", "assets/images/google.png", handleGoogleSignIn),
                        SizedBox(width: 20),
                        _buildSocialButton("Facebook", "assets/images/facebook.png", handleFacebookSignIn),
                      ],
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(height: 60),

            Expanded(
              flex: 1,
              child: Center(
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
            ),
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




