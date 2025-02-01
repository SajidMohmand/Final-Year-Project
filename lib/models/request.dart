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

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      Lawyer: lawyer,
      'formDetails': formDetails,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'],
      status: RequestStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
      lawyer: Lawyer(
        id: map['lawyerId'],
        name: '',
        domain: '',
        image: '',
        rating: '',
      ),
      formDetails: Map<String, String>.from(map['formDetails']),
    );
  }
}
