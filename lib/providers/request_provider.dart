import 'package:flutter/cupertino.dart';
import 'package:fyp2/models/request.dart';
import 'package:fyp2/models/lawyer.dart';
import 'package:fyp2/models/client.dart';
import 'package:uuid/uuid.dart';

class RequestProvider with ChangeNotifier {
  List<RequestModel> _requests = [
    RequestModel(
      id: "32434",
      lawyer: Lawyer(id: "102", name: "Emma Smith",phone: "03001111211", domain: "Corporate Law", image: 'assets/images/lawyer1.png', rating: '4.4',complaintNum: 0),
      client: Client(id: "201", name: "John Doe", phone: "1234567890", image: "assets/images/client.png", complaintNum: 2),
      status: RequestStatus.Accepted,
      formDetails: {"issue": "Company contract dispute"},
    ),
    RequestModel(
      id: "32435",
      lawyer: Lawyer(id: "103", name: "David Johnson",phone: "03001111211", domain: "Criminal Law", image: 'assets/images/lawyer2.png', rating: '4.7',complaintNum: 0),
      client: Client(id: "202", name: "Jane Doe", phone: "9876543210", image: "assets/images/client.png", complaintNum: 1),
      status: RequestStatus.Awaiting,
      formDetails: {"issue": "Fraud case"},
    ),
    RequestModel(
      id: "32436",
      lawyer: Lawyer(id: "104", name: "Michael Brown",phone: "03001111211", domain: "Family Law", image: 'assets/images/lawyer3.png', rating: '4.2',complaintNum: 0),
      client: Client(id: "203", name: "Alice Smith", phone: "1122334455", image: "assets/images/client.png", complaintNum: 3),
      status: RequestStatus.Declined,
      formDetails: {"issue": "Divorce case"},
    ),
  ];

  List<RequestModel> get requests => [..._requests];

  void addRequest(String clientName, String clientPhone, String issue, String details, Lawyer lawyer) {
    var uuid = Uuid();
    _requests.add(
      RequestModel(
        id: uuid.v4(),
        status: RequestStatus.Awaiting,
        lawyer: lawyer,
        client: Client(id: "43546", name: clientName, phone: clientPhone, image: "assets/images/lawyer1.png", complaintNum: 0),
        formDetails: {
          'issue': issue,
          'details': details,
        },
      ),
    );
    notifyListeners();
  }

  void updateRequestStatus(String requestId, RequestStatus newStatus) {
    final index = _requests.indexWhere((request) => request.id == requestId);
    if (index != -1) {
      _requests[index] = RequestModel(
        id: _requests[index].id,
        status: newStatus,
        lawyer: _requests[index].lawyer,
        client: _requests[index].client,
        formDetails: _requests[index].formDetails,
      );
      notifyListeners();
    }
  }

  void removeRequest(String requestId) {
    _requests.removeWhere((request) => request.id == requestId);
    notifyListeners();
  }

  void clearRequests() {
    _requests.clear();
    notifyListeners();
  }
}
