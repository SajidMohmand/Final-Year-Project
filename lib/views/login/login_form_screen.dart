import 'package:flutter/material.dart';
import '../register/register_screen.dart';
import '../verification_screen.dart';
import './login_screen.dart';

class LoginFormScreen extends StatefulWidget {
  final String role;

  LoginFormScreen({required this.role});

  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  String _mobileNumber = '';
  bool _isButtonEnabled = false;

  void _updateMobileNumber(String number) {
    setState(() {
      _mobileNumber = number;
      _isButtonEnabled = _isValidPhoneNumber(number);
    });
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 11 && phoneNumber.startsWith('03') && RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
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

            TextField(
              onChanged: _updateMobileNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                prefixText: "+92 ",
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerificationScreen(),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _isButtonEnabled ? Colors.brown : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 20),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Or",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                )),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton("Google", "assets/images/google.png"),
                SizedBox(width: 20),
                _buildSocialButton("Facebook", "assets/images/facebook.png"),
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

  Widget _buildSocialButton(String text, String assetPath) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
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
}
