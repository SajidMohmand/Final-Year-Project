import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/lawyer.dart';

enum RequestStatus { Accepted, Awaiting, Declined, Timeout }

class RequestModel {
  final String id;
  final RequestStatus status;
  final Lawyer lawyer;
  final Client client;
  final Map<String, String> formDetails;

  RequestModel({
    required this.id,
    required this.status,
    required this.lawyer,
    required this.client,
    required this.formDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      'lawyer': lawyer.toMap(),
      'client': client.toMap(),
      'formDetails': formDetails,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'],
      status: RequestStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
      lawyer: Lawyer(
        id: map['lawyer']['id'],
        name: map['lawyer']['name'],
        phone: map['lawyer']['phone'],
        domain: map['lawyer']['domain'],
        image: map['lawyer']['image'],
        rating: map['lawyer']['rating'],
        complaintNum: map['lawyer']['complaintNum'],
      ),
      client: Client(
        id: map['client']['id'],
        name: map['client']['name'],
        phone: map['client']['phone'],
        image: map['client']['image'],
        complaintNum: map['client']['complaintNum'],
      ),
      formDetails: Map<String, String>.from(map['formDetails']),
    );
  }
}
