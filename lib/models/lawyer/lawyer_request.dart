import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/lawyer.dart';

enum LawyerRequestStatus { Accepted, Awaiting, Declined, Timeout }

class LawyerRequest {
  final String id;
  final LawyerRequestStatus status;
  final Client client;
  final Map<String, String> formDetails;

  LawyerRequest({
    required this.id,
    required this.status,
    required this.client,
    required this.formDetails,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      Lawyer: client,
      'formDetails': formDetails,
    };
  }

  factory LawyerRequest.fromMap(Map<String, dynamic> map) {
    return LawyerRequest(
      id: map['id'],
      status: LawyerRequestStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
      client: Client(
        id: map['lawyerId'],
        name: '',
        phone: '',
        image: '',
        complaintNum: 0,
      ),
      formDetails: Map<String, String>.from(map['formDetails']),
    );
  }
}
