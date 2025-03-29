import 'package:fyp2/models/lawyer_profile.dart';
import 'package:fyp2/models/request.dart';

class Lawyer {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String image;
  final int complaintNum;
  final double rating;
  final Profile? profile;
  final RequestModel? requests;

  Lawyer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
    required this.complaintNum,
    required this.rating,
    this.profile,  // Optional
    this.requests, // Optional
  });

  // Convert to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'image': image,
      'complaintNum': complaintNum,
      'rating': rating,
      'profile': profile?.toMap(),  // Convert profile to map if not null
      'requests': requests?.toMap(), // Convert requests to map if not null
    };
  }

  // Create from Firestore document
  factory Lawyer.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Lawyer data is null");
    }

    return Lawyer(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "Unknown",
      lastName: map['lastName'] ?? "Unknown",
      phone: map['phone'] ?? "",
      email: map['email'] ?? "",
      image: map['image'] ?? "",
      complaintNum: map['complaintNum'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      profile: (map['profile'] is Map<String, dynamic>)
          ? Profile.fromMap(map['profile'])
          : null,
      requests: (map['requests'] is Map<String, dynamic>)
          ? RequestModel.fromMap(map['requests'])
          : null,
    );
  }
}
