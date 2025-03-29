import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/lawyer.dart';

enum RequestStatus { Accepted, Awaiting, Declined, Timeout, Resolve }

class RequestModel {
  final String id;
  final RequestStatus status;
  final String lawyerId;
  final String clientId;
  final Map<String, String> formDetails;

  RequestModel({
    required this.id,
    required this.status,
    required this.lawyerId,
    required this.clientId,
    required this.formDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      'lawyerId': lawyerId,
      'clientId': clientId,
      'formDetails': formDetails,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return RequestModel(
        id: '',
        status: RequestStatus.Awaiting, // Default status
        lawyerId: '',
        clientId: '',
        formDetails: {}, // Empty map
      );
    }

    return RequestModel(
      id: map['id'] ?? '',
      status: map['status'] != null
          ? RequestStatus.values.firstWhere(
            (e) => e.toString().split('.').last == map['status'],
        orElse: () => RequestStatus.Awaiting, // Default status
      )
          : RequestStatus.Awaiting, // Default status

      lawyerId: map["lawyerId"] ?? '',
      clientId: map["clientId"] ?? '',
      formDetails: map['formDetails'] != null
          ? Map<String, String>.from(map['formDetails'])
          : {}, // Empty map if null
    );
  }

}
