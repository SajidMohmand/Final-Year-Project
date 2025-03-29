import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/lawyer.dart';
import '../models/lawyer_profile.dart';

class LawyerProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Lawyer> _lawyers = [];
  List<Lawyer> _filteredLawyers = [];

  List<Lawyer> get lawyers => _lawyers;
  List<Lawyer> get filteredLawyers =>
      _filteredLawyers.isEmpty ? _lawyers : _filteredLawyers;

  LawyerProvider() {
    fetchLawyers(); // Automatically fetch data when provider is initialized
  }

  /// Fetch Lawyers from Firestore
  Future<void> fetchLawyers() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('lawyers').get();
      _lawyers = snapshot.docs
          .map((doc) => Lawyer.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching lawyers: $error");
    }
  }

  /// Filter Lawyers by Name or Domain
  void filterLawyers(String query) {
    _filteredLawyers = _lawyers.where((lawyer) {
      return lawyer.firstName.toLowerCase().contains(query.toLowerCase()) ||
          (lawyer.profile?.selectedDomains.any((domain) =>
                  domain.toLowerCase().contains(query.toLowerCase())) ??
              false);
    }).toList();
    notifyListeners();
  }

  Future<void> updateLawyerProfile(
      String lawyerId, Profile updatedProfile) async {
    try {
      await _firestore.collection('lawyers').doc(lawyerId).update({
        'profile': updatedProfile.toMap(),
      });

      // Update locally
      int index = _lawyers.indexWhere((lawyer) => lawyer.id == lawyerId);
      if (index != -1) {
        _lawyers[index] = Lawyer(
          id: _lawyers[index].id,
          firstName: _lawyers[index].firstName,
          lastName: _lawyers[index].lastName,
          phone: _lawyers[index].phone,
          email: _lawyers[index].email,
          image: _lawyers[index].image,
          profile: updatedProfile, complaintNum: _lawyers[index].complaintNum,
          rating: _lawyers[index].rating, // Updated profile field
        );
        notifyListeners();
      }
    } catch (error) {
      print("Error updating lawyer profile: $error");
    }
  }

  /// Get Lawyer by ID
  Future<Lawyer?> getLawyerById(String id) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('lawyers').doc(id).get();
      if (doc.exists) {
        return Lawyer.fromMap(doc.data() as Map<String, dynamic>?);
      }
    } catch (error) {
      print("Error fetching lawyer by ID: $error");
    }
    return null;
  }

  /// Add a Lawyer to Firestore
  Future<void> addLawyer(Lawyer lawyer) async {
    try {
      await _firestore.collection('lawyers').doc(lawyer.id).set(lawyer.toMap());
      _lawyers.add(lawyer);
      notifyListeners();
    } catch (error) {
      print("Error adding lawyer: $error");
    }
  }

  Future<List<Map<String, String>>?> getResolvedCases() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? lawyerId = auth.currentUser?.uid;
    try {
      DocumentSnapshot doc =
          await _firestore.collection('lawyers').doc(lawyerId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Extract 'profile' field
        Map<String, dynamic>? profile =
            data['profile'] as Map<String, dynamic>?;

        if (profile != null && profile.containsKey('resolveCases')) {
          List<dynamic> resolveCasesList = profile['resolveCases'];

          // Ensure the list contains maps
          return resolveCasesList.cast<Map<String, String>>();
        }
      }
      return null; // Return null if no data found
    } catch (error) {
      print("Error fetching resolved cases: $error");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchEducation() async {
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

      if (profileData == null || profileData['education'] == null) return [];

      List<Map<String, dynamic>> educationList =
          List<Map<String, dynamic>>.from(profileData['education']);

      return educationList;
    } catch (e) {
      print("Error fetching profile: $e");
      return [];
    }
  }

  Future<void> updateEducation({
    required List<Map<String, dynamic>> updatedEducationList,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;

    try {
      DocumentReference lawyerRef = _firestore.collection('lawyers').doc(lawyerId);

      // Fetch current profile data
      DocumentSnapshot snapshot = await lawyerRef.get();
      if (!snapshot.exists) {
        print("Lawyer document does not exist.");
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey("profile") && data["profile"] != null) {
        // Update the whole education list
        await lawyerRef.update({
          "profile.education": updatedEducationList,
        });

        print("Education list updated successfully.");
      }
    } catch (e) {
      print("Error updating education: $e");
    }
  }



  Future<List<String>> fetchDomains() async {
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

      if (profileData == null || profileData['domain'] == null) return [];

      List<String> domains = List<String>.from(profileData['domain']);

      return domains;
    } catch (e) {
      print("Error fetching domains: $e");
      return [];
    }
  }


}
