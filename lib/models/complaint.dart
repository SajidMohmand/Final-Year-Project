import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/lawyer.dart';

enum ComplaintStatus { Waiting, Resolved }

class Complaint {
  final String id;
  final int complaintNum;
  final String complainantType;
  final Lawyer complainantDetails;
  final Client respondentDetails;
  final Map<String, String> complaintDetails;
  ComplaintStatus status;

  Complaint({
    required this.id,
    required this.complaintNum,
    required this.complainantType,
    required this.complainantDetails,
    required this.respondentDetails,
    required this.complaintDetails,
    ComplaintStatus? status, // Allow null but handle it below
  }) : status = status ?? ComplaintStatus.Waiting; // Assign default if null

  void updateStatus(ComplaintStatus newStatus) {
    status = newStatus;
  }
}
