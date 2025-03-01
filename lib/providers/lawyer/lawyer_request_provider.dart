import 'package:flutter/cupertino.dart';
import 'package:fyp2/models/client.dart';
import 'package:uuid/uuid.dart';

import '../../models/lawyer/lawyer_request.dart';

class LawyerRequestProvider with ChangeNotifier {
  List<LawyerRequest> _requests = [
    LawyerRequest(
      id: "32434",
      client: Client(id: "102", name: "Emma Smith", phone: "03001121222", image: 'assets/images/lawyer1.png',complaintNum: 1),
      status: LawyerRequestStatus.Awaiting,
      formDetails: {"name" : "Ali Ahmad","phone": "03002343344","issue": "Hacking / Unauthorized Access","details": "Company contract dispute"},
    ),

  ];

  List<LawyerRequest> get requests => [..._requests];

  LawyerRequest? findRequestById(String requestId) {
    var filteredRequests = _requests.where((request) => request.id == requestId);
    return filteredRequests.isNotEmpty ? filteredRequests.first : null;
  }

  void addRequest(String name, String phone, String issue, String details, Client client) {
    var uuid = Uuid();


    _requests.add(
      LawyerRequest(
        id: uuid.v4(),
        status: LawyerRequestStatus.Awaiting,
        client: client,
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

  void updateRequestStatus(String requestId, LawyerRequestStatus newStatus) {
    final index = _requests.indexWhere((request) => request.id == requestId);
    if (index != -1) {
      _requests[index] = LawyerRequest(
        id: _requests[index].id,
        status: newStatus,
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
