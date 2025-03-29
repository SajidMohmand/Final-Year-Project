import 'package:fyp2/models/client_profile.dart';
import 'package:fyp2/models/request.dart';

class Client {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String image;
  final int complaintNum;
  final ClientProfile? profile;
  final List<RequestModel?> requests;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
    required this.complaintNum,
    this.profile,  // Optional
    this.requests = const [], // Default to empty list
  });

  /// Convert Client object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'image': image,
      'complaintNum': complaintNum,
      'profile': profile?.toMap(), // Convert profile to map if not null
      'requests': requests.map((request) => request?.toMap()).toList(), // Convert list to map
    };
  }

  /// Convert Map (Firestore) to Client object
  factory Client.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Client data is null");
    }

    return Client(
      id: map['id'] ?? "", // Default empty string if null
      firstName: map['firstName'] ?? "Unknown",
      lastName: map['lastName'] ?? "Unknown",
      phone: map['phone'] ?? "",
      email: map['email'] ?? "",
      image: map['image'] ?? "",
      complaintNum: map['complaintNum'] ?? 0,
      profile: map['profile'] != null ? ClientProfile.fromMap(map['profile']) : null,
        requests: map['requests'] != null
            ? List<RequestModel>.from(map['requests']) // Expecting `List<RequestModel>`
            : [],
    );
  }
}
