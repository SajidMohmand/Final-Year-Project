import 'package:flutter/material.dart';
import '../models/lawyer.dart';

class LawyerProvider with ChangeNotifier {
  final List<Lawyer> _lawyers = [
    Lawyer(
      id: "1",
      name: "John Doe",
      domain: "Cyber Harassment",
      image: "assets/images/lawyer1.png",
      rating: "4.5",
    ),
    Lawyer(
      id: "2",
      name: "Jane Smith",
      domain: "Cyber Harassment",
      image: "assets/images/lawyer2.png",
      rating: "4.7",
    ),
    Lawyer(
      id: "3",
      name: "Michael Johnson",
      domain: "Family Law",
      image: "assets/images/lawyer3.png",
      rating: "4.6",
    ),
    Lawyer(
      id: "4",
      name: "Capital Johnson",
      domain: "Family Law",
      image: "assets/images/lawyer4.png",
      rating: "4.0",
    ),
    Lawyer(
      id: "5",
      name: "Alice Brown",
      domain: "Business Law",
      image: "assets/images/lawyer1.png",
      rating: "4.2",
    ),
  ];

  List<Lawyer> get lawyers => [..._lawyers];

  List<Lawyer> _filteredLawyers = [];

  List<Lawyer> get filteredLawyers =>
      _filteredLawyers.isEmpty ? _lawyers : _filteredLawyers;

  void filterLawyers(String query) {
    _filteredLawyers = _lawyers.where((lawyer) {
      return lawyer.domain.toLowerCase().contains(query.toLowerCase()) ||
          lawyer.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  Lawyer? getLawyerById(String id) {
    return _lawyers.firstWhere(
          (lawyer) => lawyer.id == id,
      orElse: () => Lawyer(
        id: "",
        name: "Unknown",
        domain: "Not Available",
        image: "assets/images/lawyer1.png",
        rating: "0.0",
      ),
    );
  }
}
