enum RequestStatus { Accepted, Awaiting, Declined, Timeout }


class Request {
  final String id;
  final RequestStatus status;
  final String lawyerId;
  final Map<String, String> formDetails;

  Request({
    required this.id,
    required this.status,
    required this.lawyerId,
    required this.formDetails,
  });

  // Convert model to Map for Firebase or local storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last, // Convert enum to string
      'lawyerId': lawyerId,
      'formDetails': formDetails,
    };
  }

  // Factory constructor to create object from Map
  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'],
      status: RequestStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
      lawyerId: map['lawyerId'],
      formDetails: Map<String, String>.from(map['formDetails']),
    );
  }
}
