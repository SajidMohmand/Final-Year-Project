import 'package:flutter/cupertino.dart';
import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/complaint.dart';
import 'package:fyp2/models/lawyer.dart';
import 'package:uuid/uuid.dart';

class ComplaintProvider with ChangeNotifier {
  List<Complaint> _complaints = [
    Complaint(
      id: Uuid().v4(),
      complaintNum: 1,
      complainantType: "Client",
      complainantDetails: Lawyer(id: "1", name: "sajid", domain: "cyber law", image: "assets/images/lawyer1.png", rating: "4.5"),
      respondentDetails: Client(id: "234", name: "Jonhy capital",phone: "03002343233", image: "assets/images/lawyer3.png",complaintNum: 1),
      complaintDetails: {
        "issue": "Delayed case proceedings",
        "details": "The lawyer has not been responding to calls and emails for the past two weeks.",
      },
    ),
  ];
  List<Complaint> get complaints => [..._complaints];

  void fileComplaint({
    required String complainantType, // "Lawyer" or "Client"
    required int complaintNum,
    required Lawyer complainantDetails, // Lawyer or Client details
    required Client respondentDetails, // Lawyer or Client details
    required Map<String, String> complaintDetails, // Complaint issue and details
  }) {
    var uuid = Uuid();

    _complaints.add(
      Complaint(
        id: uuid.v4(),
        complainantType: complainantType,
        complaintNum: complaintNum,
        complainantDetails: complainantDetails,
        respondentDetails: respondentDetails,
        complaintDetails: complaintDetails,
      ),
    );

    notifyListeners();
  }

  void removeComplaint(String complaintId) {
    _complaints.removeWhere((complaint) => complaint.id == complaintId);
    notifyListeners();
  }

  void clearComplaints() {
    _complaints.clear();
    notifyListeners();
  }
}
