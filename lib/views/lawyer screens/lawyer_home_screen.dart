import 'dart:math';

import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import './tabs/lawyer_chatbot_screen.dart';
import './tabs/lawyer_find_lawyer_screen.dart';
import './tabs/lawyer_request_screen.dart';
import './tabs/lawyer_chat_screen.dart';
import './tabs/lawyer_profile_screen.dart';

class LawyerHomeScreen extends StatefulWidget {
  @override
  _LawyerHomeScreenState createState() => _LawyerHomeScreenState();
}

class _LawyerHomeScreenState extends State<LawyerHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    LawyerChatbotScreen(),
    LawyerFindLawyerScreen(),
    LawyerRequestScreen(),
    LawyerChatScreen(),
    LawyerProfileScreen(),
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
