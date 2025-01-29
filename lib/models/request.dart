import 'package:fyp2/models/lawyer.dart';

enum RequestStatus { Accepted, Awaiting, Declined, Timeout }

class Request {
  final String id;
  final RequestStatus status;
  final Lawyer lawyer;
  final Map<String, String> formDetails;

  Request({
    required this.id,
    required this.status,
    required this.lawyer,
    required this.formDetails,
  });

  // Convert model to Map for Firebase or local storage
  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last, // Convert enum to string
      Lawyer: lawyer, // Use lawyer.id instead of lawyerId
      'formDetails': formDetails,
    };
  }

  // Factory constructor to create object from Map
  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'],
      status: RequestStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
      lawyer: Lawyer(
        id: map['lawyerId'], // Assuming you have the lawyer's id
        name: '', // You need to fetch the name, domain, image, rating based on your logic
        domain: '',
        image: '',
        rating: '',
      ),
      formDetails: Map<String, String>.from(map['formDetails']),
    );
  }
}
