import 'dart:math';

import 'package:flutter/material.dart';
import './tabs/chatbot_screen.dart';
import './tabs/find_lawyer_screen.dart';
import './tabs/request_screen.dart';
import './tabs/chat_screen.dart';
import './tabs/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ChatbotScreen(),
    FindLawyerScreen(),
    RequestScreen(),
    ChatScreen(),
    ProfileScreen(),
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
      body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.brown.shade50,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.amber.shade700,
          unselectedItemColor: Colors.brown.shade400,
          selectedFontSize: 14,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
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
                angle: -pi / 4,
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
