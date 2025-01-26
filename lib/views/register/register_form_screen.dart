import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import './register_screen.dart';
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
            // Dynamic Title (Hi, Lawyer / Hi, Client)

            SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("First Name", firstNameController),
                  SizedBox(height: 20),
                  _buildTextField("Last Name", lastNameController),
                  SizedBox(height: 20),
                  _buildTextField("Email (Optional)", emailController, TextInputType.emailAddress),
                  SizedBox(height: 20),
                  _buildTextField("Mobile Number *", mobileController, TextInputType.phone),
                  SizedBox(height: 20),

                  // Continue Button (Full Width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VerificationScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade600,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text("Or",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100),),
                  SizedBox(height: 20),

                  // Social Media Login (Google & Facebook)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton("Google", "assets/images/google.png"),
                      SizedBox(width: 20),
                      _buildSocialButton("Facebook", "assets/images/facebook.png"),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),

            // Already have an account? Login
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(),
                    ),
                  );
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

  // Function to Build TextFields
  Widget _buildTextField(String label, TextEditingController controller, [TextInputType inputType = TextInputType.text, bool isRequired = false]) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: isRequired ? (value) => value!.isEmpty ? "$label is required" : null : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
      ),
    );
  }

  // Function to Build Social Buttons
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
            side: BorderSide(color: Colors.brown, width: 2), // Added border
          ),
          backgroundColor: Colors.white, // Optional: Set background color
          foregroundColor: Colors.brown, // Text and icon color
        ),
      ),
    );
  }

}
