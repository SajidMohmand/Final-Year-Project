import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // Bio Controller
  late TextEditingController bioController = TextEditingController();

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



  List<Map<String, String>> _experiences = [];

  List<Map<String, String>> get experiences => _experiences;

  void addExperience(Map<String, String> experience) {
    _experiences.add(experience);
    notifyListeners();
  }

  void setExperiences(List<Map<String, String>> experiences) {
    _experiences = experiences;
    notifyListeners();
  }

  void clearExperiences() {
    _experiences.clear();
    notifyListeners();
  }

  String? gender;
  String? country;
  String? city;

  void updateProfile({String? newGender, String? newCountry, String? newCity}) {
    gender = newGender ?? gender;
    country = newCountry ?? country;
    city = newCity ?? city;
    notifyListeners();
  }

  String? selectedAvailability;
  TextEditingController availabilityController = TextEditingController();

  // Selected Domains
  List<String> selectedDomains = [];
  void updateDomains(List<String> domains) {
    selectedDomains = domains;
    notifyListeners();
  }
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
    String? availability,
  }) {
    selectedAvailability = availability;
    notifyListeners();
  }





  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    bioController.dispose();
    availabilityController.dispose();

    super.dispose();
  }
}
