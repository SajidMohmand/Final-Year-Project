import 'lawyer.dart';

class ClientProfile {
  final String address;
  final List<Lawyer> connectedLawyer;
  final List<Map<dynamic, dynamic>> resolveCases;

  ClientProfile({
    required this.address,
    required this.connectedLawyer,
    required this.resolveCases,
  });

  // Convert object to a map
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'connectedLawyer': connectedLawyer.map((lawyer) => lawyer.toMap()).toList(),
      'resolveCases': resolveCases,
    };
  }

  // Create object from a map
  factory ClientProfile.fromMap(Map<String, dynamic> map) {
    return ClientProfile(
      address: map['address'],
      connectedLawyer: (map['connectedLawyer'] as List)
          .map((lawyer) => Lawyer.fromMap(lawyer))
          .toList(),
      resolveCases: List<Map<dynamic, dynamic>>.from(map['resolveCases']),
    );
  }
}
