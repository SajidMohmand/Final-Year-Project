import 'package:flutter/cupertino.dart';
import 'package:fyp2/models/request.dart';
import 'package:fyp2/models/lawyer.dart'; // Import Lawyer model
import 'package:uuid/uuid.dart';

class RequestProvider with ChangeNotifier {
  List<Request> _requests = [
    // Request(
    //   id: "32434",
    //   lawyer: Lawyer(id: "102", name: "Emma Smith", domain: "Corporate Law", image: 'assets/images/lawyer1', rating: '4.4'),
    //   status: RequestStatus.Accepted,
    //   formDetails: {"issue": "Company contract dispute"},
    // ),
  ];

  List<Request> get requests => [..._requests];

  // Add a new request
  void addRequest(String name, String phone, String issue, String details, Lawyer lawyer) {
    var uuid = Uuid();


    _requests.add(
      Request(
        id: uuid.v4(), // Generate unique ID
        status: RequestStatus.Awaiting, // Default status
        lawyer: lawyer, // Pass Lawyer object here
        formDetails: {
          'name': name,
          'phone': phone,
          'issue': issue,
          'details': details,
        },
      ),
    );
    notifyListeners();
  }

  // Update the status of a request
  void updateRequestStatus(String requestId, RequestStatus newStatus) {
    final index = _requests.indexWhere((request) => request.id == requestId);
    if (index != -1) {
      _requests[index] = Request(
        id: _requests[index].id,
        status: newStatus,
        lawyer: _requests[index].lawyer, // Keep the existing Lawyer object
        formDetails: _requests[index].formDetails,
      );
      notifyListeners();
    }
  }

  // Remove a request
  void removeRequest(String requestId) {
    _requests.removeWhere((request) => request.id == requestId);
    notifyListeners();
  }

  // Clear all requests
  void clearRequests() {
    _requests.clear();
    notifyListeners();
  }
}
