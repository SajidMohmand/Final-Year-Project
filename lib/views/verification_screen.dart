import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './lawyer screens/profileSetup/setup_profile_screen.dart';
import 'lawyer screens/lawyer_home_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String verificationId;
  final String role;

  VerificationScreen({required this.verificationId,required this.role});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  int currentIndex = 0;
  bool _agreedToTerms = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isResending = false;

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
    } else if (currentIndex < 6) {
      setState(() {
        controllers[currentIndex].text = value;
        if (currentIndex < 5) {
          currentIndex++;
          FocusScope.of(context).requestFocus(focusNodes[currentIndex]);
        }
      });

      if (controllers.every((controller) => controller.text.isNotEmpty)) {
        _verifyCode();
      }
    }
  }

  void _verifyCode() async {
    String otpCode = controllers.map((controller) => controller.text).join();
    print("Entered OTP: $otpCode");

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpCode,
      );

      await _auth.signInWithCredential(credential);
      _showTermsDialog();
    } catch (e) {
      print("Verification failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Verification failed! Please try again."),
      ));
    }
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

                    if(widget.role.substring(0,2) == 'rL'){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileSetupScreen()),
                      );
                    }else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }

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

  Future<void> _resendOTP() async {
    setState(() {
      _isResending = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+1234567890', // Add the phone number you're verifying
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isResending = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to resend OTP! Please try again."),
          ));
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isResending = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("OTP resent successfully."),
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isResending = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _isResending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error resending OTP: $e"),
      ));
    }
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
            Text("Enter the six-digit code you received by SMS",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Didn’t receive the code? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _isResending ? null : _resendOTP,
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
              children: List.generate(6, (index) => _buildCodeField(index)),
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
      width: 50,
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
