import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/register_provider.dart';
import 'login_form_screen.dart';
import '../register/register_form_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), // Added horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),

            // **Centered Image**
            Center(
              child: Image.asset(
                "assets/images/splash.png",
                width: 120,
                height: 120,
              ),
            ),

            SizedBox(height: 30),

            // **Title and Subtitle with Proper Padding**
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

            // **Role Selection (Client / Lawyer)**
            Consumer<RegisterProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RoleBox(
                        title: "Client",
                        imagePath: "assets/images/client.png",
                        isSelected: provider.selectedRole == "Client",
                        onTap: () => provider.selectRole("Client"),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: RoleBox(
                        title: "Lawyer",
                        imagePath: "assets/images/lawyer.png",
                        isSelected: provider.selectedRole == "Lawyer",
                        onTap: () => provider.selectRole("Lawyer"),
                      ),
                    ),
                  ],
                );
              },
            ),

            Spacer(),

            // **Full-Width Next Button**
            Consumer<RegisterProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.selectedRole.isNotEmpty
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginFormScreen(role: provider.selectedRole),
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
                );
              },
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

  RoleBox(
      {required this.title,
        required this.imagePath,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160, // Increased Height
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown.shade400 : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.brown.withOpacity(0.4),
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // **Image**
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10),

            // **Text**
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
