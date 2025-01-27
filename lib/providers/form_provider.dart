import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  Map<String, String> _formDetails = {};

  Map<String, String> get formDetails => _formDetails;

  void saveFormDetails(String name, String phone, String issue, String details) {
    _formDetails = {
      'name': name,
      'phone': phone,
      'issue': issue,
      'details': details,
    };
    notifyListeners();
  }
}
