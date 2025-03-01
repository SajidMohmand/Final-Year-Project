import 'package:flutter/material.dart';
import 'package:fyp2/views/admin%20screens/admin_home_screen.dart';
import 'package:fyp2/widgets/app_drawer.dart';

import '../register/register_screen.dart';


class AdminLogin extends StatefulWidget {
  String role;
  AdminLogin({required this.role});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileController = TextEditingController();

  bool isLoading = false;

  bool _isButtonEnabled = false;

  void helper() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = true;
      });

      if (mobileController.text == "03000000000") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomeScreen(),
          ),
        );
      }
    });
  }


  void _updateMobileNumber(String number) {
    setState(() {
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Mobile Number *", mobileController, TextInputType.phone, isRequired: true),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? helper : null,
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
