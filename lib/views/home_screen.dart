import 'dart:math';

import 'package:flutter/material.dart';
import './tabs/chatbot_screen.dart';  // Chatbot screen
import './tabs/find_lawyer_screen.dart'; // Find Lawyer screen
import './tabs/request_screen.dart'; // Request screen
import './tabs/chat_screen.dart'; // Chat screen
import './tabs/profile_screen.dart'; // Profile screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ChatbotScreen(),    // Chatbot tab
    FindLawyerScreen(), // Find Lawyer tab
    RequestScreen(),    // Request tab
    ChatScreen(),       // Chat tab
    ProfileScreen(),    // Profile tab
  ];

  void _onItemTapped(int index) {
    if (index >= 0 && index < _screens.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display selected screen
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.brown.shade50, // Light brown background
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.amber.shade700, // Gold-ish color for selected tab
          unselectedItemColor: Colors.brown.shade400, // Dark brown for unselected tabs
          selectedFontSize: 14,
          elevation: 8, // Add shadow to lift the bar
          type: BottomNavigationBarType.fixed, // Allow more than 3 items
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chatbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Find Lawyer',
            ),
            BottomNavigationBarItem(
              icon: Transform.rotate(
                angle: -pi / 4, // Rotates the icon 45 degrees upward
                child: Icon(Icons.send),
              ),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        )

    );
  }
}
