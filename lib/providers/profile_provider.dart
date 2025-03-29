import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/lawyer_profile.dart';

class ProfileProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers
  TextEditingController bioController = TextEditingController();

  // Fetch Profile from Firestore
  Future<Profile?> fetchProfile(String lawyerId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('lawyers').doc(lawyerId).get();
      if (doc.exists) {
        return Profile.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
    return null;
  }

  // Update Bio in Firestore
  Future<void> updateBio(String bio) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(lawyerId)
        .update({
      'profile.bio': bio, // Correct way to update a nested field
    });
    notifyListeners();
  }

  // Update Profile Data in Firestore
  Future<void> updateProfile({
    String? gender,
    String? country,
    String? city,
    String? availability,
  }) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String lawyerId = auth.currentUser!.uid;

      Map<String, dynamic> updates = {};
      if (gender != null) updates['profile.gender'] = gender;
      if (country != null) updates['profile.country'] = country;
      if (city != null) updates['profile.city'] = city;
      if (availability != null) updates['profile.selectedAvailability'] = availability;

      await FirebaseFirestore.instance.collection('lawyers').doc(lawyerId).update(updates);
      print("Profile updated successfully!");
    } catch (e) {
      print("Failed to update profile: $e");
      throw Exception("Profile update failed: $e");
    }
  }


  Future<void> addEducation(List<Map<String, dynamic>> educationList) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(lawyerId)
        .update({
      'profile.education': educationList, // Correct way to update a list inside the profile map
    });
  }



  Future<void> clearEducation(String lawyerId) async {
    await _firestore.collection('lawyers').doc(lawyerId).update({'education': []});
    notifyListeners();
  }

  // Manage Experiences
  Future<void> addExperience(Map<String, String> experience) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String lawyerId = auth.currentUser!.uid;
      DocumentReference docRef = FirebaseFirestore.instance.collection('lawyers').doc(lawyerId);

      await docRef.update({
        'profile.experience': FieldValue.arrayUnion([experience]), // Append new experience
      });

      notifyListeners();
    } catch (e, stackTrace) {
      print("Error adding experience: $e");
      print(stackTrace); // Print stack trace for debugging
    }
  }

  Future<void> updateExperience(int index, Map<String, String> updatedExperience) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String lawyerId = auth.currentUser!.uid;
      DocumentReference docRef = FirebaseFirestore.instance.collection('lawyers').doc(lawyerId);

      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('profile') && data['profile'] != null) {
          var profile = data['profile'] as Map<String, dynamic>;
          if (profile.containsKey('experience') && profile['experience'] != null) {
            List<Map<String, dynamic>> experiences = List<Map<String, dynamic>>.from(profile['experience']);

            if (index >= 0 && index < experiences.length) {
              experiences[index] = updatedExperience; // Update the specific experience entry

              await docRef.update({
                'profile.experience': experiences,
              });

              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      print("Error updating experience: $e");
    }
  }


  Future<List<Map<String, String>>> fetchExperience() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(lawyerId)
          .get();

      if (!doc.exists) return [];

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic>? profileData = data['profile'];

      if (profileData == null || profileData['experience'] == null) return [];

      List<dynamic> rawExperiences = profileData['experience']; // Firestore returns List<dynamic>

      List<Map<String, String>> experienceList = [];

      for (var exp in rawExperiences) {
        if (exp is Map<String, dynamic>) {
          experienceList.add(
            exp.map((key, value) => MapEntry(key, value.toString())),
          );
        }
      }

      return experienceList;
    } catch (e, stackTrace) {
      print("Error fetching experience: $e");
      print(stackTrace); // Print stack trace for debugging
      return [];
    }
  }

  Future<void> deleteExperience(int index) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;
    try {
      DocumentReference lawyerRef =
      _firestore.collection('lawyers').doc(lawyerId);

      // Fetch the current profile
      DocumentSnapshot snapshot = await lawyerRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        if (data.containsKey("profile") && data["profile"] != null) {
          Map<String, dynamic> profile = data["profile"];
          List<dynamic> experiences = List.from(profile["experience"] ?? []);

          if (index >= 0 && index < experiences.length) {
            experiences.removeAt(index); // Remove experience at given index

            // Update Firestore
            await lawyerRef.update({
              "profile.experience": experiences,
            });

            notifyListeners(); // Notify UI to update
          }
        }
      }
    } catch (e) {
      print("Error deleting experience: $e");
    }
  }


  Future<void> clearExperiences(String lawyerId) async {
    await _firestore.collection('lawyers').doc(lawyerId).update({'profile.experience': []});
    notifyListeners();
  }

  // Manage Domains
  Future<void> updateDomains(List<String> domains) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;
    await _firestore.collection('lawyers').doc(lawyerId).update({'profile.domain': domains});
    notifyListeners();
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }
}
