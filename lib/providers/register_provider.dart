import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  String _selectedRole = '';

  String get selectedRole => _selectedRole;

  void selectRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
  void clearRole() {
    _selectedRole = '';
    notifyListeners();
  }
}
