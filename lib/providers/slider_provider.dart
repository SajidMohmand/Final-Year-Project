import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  int _currentPage = 0; // Renamed _currentIndex to _currentPage for consistency

  int get currentPage => _currentPage; // Updated getter name

  void setPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
