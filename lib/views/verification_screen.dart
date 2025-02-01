import 'package:flutter/material.dart';
import 'home_screen.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  int currentIndex = 0;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onKeyPressed(String value) {
    if (value == "delete") {
      if (currentIndex > 0) {
        setState(() {
          controllers[currentIndex - 1].clear();
          currentIndex--;
          FocusScope.of(context).requestFocus(focusNodes[currentIndex]);
        });
      }
    } else if (currentIndex < 4) {
      setState(() {
        controllers[currentIndex].text = value;
        if (currentIndex < 3) {
          currentIndex++;
          FocusScope.of(context).requestFocus(focusNodes[currentIndex]);
        }
      });

      if (controllers.every((controller) => controller.text.isNotEmpty)) {
        _verifyCode();
      }
    }
  }

  void _verifyCode() {
    String otpCode = controllers.map((controller) => controller.text).join();
    print("Entered OTP: $otpCode");
    _showTermsDialog();
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool agreedToTerms = _agreedToTerms;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Terms and Services"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please read and agree to our Terms of Service and Privacy Policy before proceeding.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: agreedToTerms,
                        activeColor: Colors.brown,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setDialogState(() {
                            agreedToTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "I agree with the Terms of Service and Privacy Policy",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Decline",
                    style: TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: agreedToTerms
                      ? () {
                    setState(() {
                      _agreedToTerms = agreedToTerms;
                    });
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        agreedToTerms ? Colors.brown : Colors.transparent),
                    foregroundColor: WidgetStateProperty.all(
                        agreedToTerms ? Colors.white : Colors.brown),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  ),
                  child: Text(
                    "Accept",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Verification Code",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Enter the four-digit code you received by SMS",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Didn’t receive the code?",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                  },
                  child: Text("Resend",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown.shade700,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (index) => _buildCodeField(index)),
            ),

            SizedBox(height: 30),

            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeField(int index) {
    return Container(
      width: 60,
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.none,
        textAlign: TextAlign.center,
        maxLength: 1,
        readOnly: true,
        decoration: InputDecoration(
          counterText: "",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade700, width: 2),
          ),

        ),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        for (var row in [
          ["1", "2", "3"],
          ["4", "5", "6"],
          ["7", "8", "9"],
          ["", "0", "delete"]
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((value) {
              return _buildNumberButton(value);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildNumberButton(String value) {
    return GestureDetector(
      onTap: () => value.isNotEmpty ? _onKeyPressed(value) : null,
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.all(10),

        child: Center(
          child: value == "delete"
              ? Icon(Icons.backspace, size: 30)
              : Text(
            value,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
