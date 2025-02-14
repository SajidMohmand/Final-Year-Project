import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // Bio Controller
  late final TextEditingController bioController;

  void updateController(bio){
    bioController = bio;
  }

  // Education Fields
  String? selectedMasterField;
  String? selectedMasterUniversity;
  String? selectedMasterYear;
  String? selectedBachelorField;
  String? selectedBachelorUniversity;
  String? selectedBachelorYear;

  // Experience List
  List<Map<String, TextEditingController>> experiences = [
    {
      "title": TextEditingController(),
      "company": TextEditingController(),
      "location": TextEditingController(),
      "startDate": TextEditingController(),
      "endDate": TextEditingController(),
    }
  ];

  // Personal Details
  String? selectedGender;
  String? selectedCountry;
  String? selectedCity;
  String? selectedAvailability;
  TextEditingController availabilityController = TextEditingController();

  // Selected Domains
  List<String> selectedDomains = [];

  // Methods to Update Profile Data
  void updateMasterEducation(String field, String university, String year) {
    selectedMasterField = field;
    selectedMasterUniversity = university;
    selectedMasterYear = year;
    notifyListeners();
  }

  void updateBachelorEducation(String field, String university, String year) {
    selectedBachelorField = field;
    selectedBachelorUniversity = university;
    selectedBachelorYear = year;
    notifyListeners();
  }

  void updatePersonalDetails({
    String? gender,
    String? country,
    String? city,
    String? availability,
  }) {
    selectedGender = gender;
    selectedCountry = country;
    selectedCity = city;
    selectedAvailability = availability;
    notifyListeners();
  }

  void addExperience() {
    experiences.add({
      "title": TextEditingController(),
      "company": TextEditingController(),
      "location": TextEditingController(),
      "startDate": TextEditingController(),
      "endDate": TextEditingController(),
    });
    notifyListeners();
  }

  void removeExperience(int index) {
    experiences.removeAt(index);
    notifyListeners();
  }

  void updateDomains(List<String> domains) {
    selectedDomains = domains;
    notifyListeners();
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    bioController.dispose();
    availabilityController.dispose();
    for (var exp in experiences) {
      exp.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }
}
