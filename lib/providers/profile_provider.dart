import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  // Profile Data
  Profile profile = Profile(id: '1');

  // Controllers
  TextEditingController bioController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();

  // Update Bio
  void updateBio(String bio) {
    profile.bio = bio;
    notifyListeners();
  }

  // Update Profile Data
  void updateProfile({String? gender, String? country, String? city, String? availability}) {
    profile.gender = gender ?? profile.gender;
    profile.country = country ?? profile.country;
    profile.city = city ?? profile.city;
    profile.selectedAvailability = availability ?? profile.selectedAvailability;
    notifyListeners();
  }

  // Manage Education
  void addEducation(String level, String field, String university, String year) {
    int index = profile.education.indexWhere((edu) => edu['level'] == level);

    if (index != -1) {
      // Update existing entry
      profile.education[index] = {
        'level': level,
        'field': field,
        'university': university,
        'year': year,
      };
    } else {
      // Add new entry if not found
      profile.education.add({
        'level': level,
        'field': field,
        'university': university,
        'year': year,
      });
    }
    notifyListeners();
  }

  void clearEducation() {
    profile.education.clear();
    notifyListeners();
  }

  // Manage Experiences
  void addExperience(Map<String, String> experience) {
    profile.experiences.add(experience);
    notifyListeners();
  }

  void setExperiences(List<Map<String, String>> experiences) {
    profile.experiences = experiences;
    notifyListeners();
  }

  void clearExperiences() {
    profile.experiences.clear();
    notifyListeners();
  }

  // Manage Domains
  void updateDomains(List<String> domains) {
    profile.selectedDomains = domains;
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
