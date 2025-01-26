import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        centerTitle: true, // Centers the image
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // Adjust the value as needed
          child: Image.asset(
            'assets/images/splash.png',
            height: 50, // Adjust size as needed
          ),
        ),
      ),
      body: Center( // Centers all the content within the screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the rest of the content
            crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
            children: [
              Text(
                "How Can I Help You?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), // Space between title and input field
              TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  hintText: "Enter your query...",
                  hintStyle: TextStyle(color: Colors.brown,fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background color
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Padding inside
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded, color: Colors.brown),
                    onPressed: () {
                      print("User Query: ${_queryController.text}");
                      _queryController.clear();
                    },
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
