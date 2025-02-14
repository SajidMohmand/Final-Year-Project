import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';

class ClientChatbotScreen extends StatefulWidget {
  @override
  _ClientChatbotScreenState createState() => _ClientChatbotScreenState();
}

class _ClientChatbotScreenState extends State<ClientChatbotScreen> {
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset(
            'assets/images/splash.png',
            height: 50,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "How Can I Help You?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  hintText: "Enter your query...",
                  hintStyle: TextStyle(color: Colors.brown,fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
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
