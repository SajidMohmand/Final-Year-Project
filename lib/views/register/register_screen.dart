import 'package:flutter/material.dart';
import 'package:fyp2/views/admin%20screens/admin_login.dart';
import 'package:fyp2/views/login/login_form_screen.dart';
import 'package:fyp2/views/login/login_screen.dart';
import 'register_form_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedRole = "";

  void _selectRole(String role) {
    setState(() {
      _selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Aligns button to the right
          children: [
            TextButton(
              onPressed: () {
                _selectRole("Admin");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AdminLogin(role: _selectedRole),
                  ),
                );
              },
              child: Text(
                "Are You Admin?",
                style: TextStyle(
                  color: Colors.brown, // Makes text white for better visibility
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),

            Center(
              child: Image.asset(
                "assets/images/splash.png",
                width: 120,
                height: 120,
              ),
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Who are You?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "I am a...",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoleBox(
                    title: "Client",
                    imagePath: "assets/images/client.png",
                    isSelected: _selectedRole == "rClient",
                    onTap: () => _selectRole("rClient"),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: RoleBox(
                    title: "Lawyer",
                    imagePath: "assets/images/lawyer.png",
                    isSelected: _selectedRole == "rLawyer",
                    onTap: () => _selectRole("rLawyer"),
                  ),
                ),
              ],
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedRole.isNotEmpty
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RegisterFormScreen(role: _selectedRole),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class RoleBox extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  RoleBox({
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown.shade400 : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.brown.shade400,
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10),

            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
