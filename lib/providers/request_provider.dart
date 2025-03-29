import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp2/models/request.dart';
import 'package:fyp2/models/lawyer.dart';
import 'package:fyp2/models/client.dart';
import 'package:uuid/uuid.dart';

class RequestProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<RequestModel> _requests = [];

  List<RequestModel> get requests => [..._requests];

  /// Fetch Requests from Firestore using request IDs stored in the client document
  Future<void> fetchRequests() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser!.uid;

    try {
      final clientDoc = await _firestore.collection('clients').doc(id).get();

      if (clientDoc.exists && clientDoc.data()!.containsKey('requests')) {
        List<String> requestIds = List<String>.from(clientDoc['requests']);

        if (requestIds.isNotEmpty) {
          var requestSnapshots = await _firestore.collection('requests')
              .where(FieldPath.documentId, whereIn: requestIds)
              .get();

          _requests = requestSnapshots.docs.map((doc) => RequestModel.fromMap(doc.data())).toList();

          notifyListeners();
        }
      }
    } catch (error) {
      print("Error fetching requests: $error");
    }
  }



  Future<void> fetchLawyerRequests() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    String lawyerId = auth.currentUser!.uid;
    try {
      final lawyerDoc = await _firestore.collection('lawyers').doc(lawyerId).get();

      if (lawyerDoc.exists && lawyerDoc.data()!.containsKey('requests')) {
        List<String> requestIds = List<String>.from(lawyerDoc['requests']);

        if (requestIds.isNotEmpty) {
          var requestSnapshots = await _firestore.collection('requests')
              .where(FieldPath.documentId, whereIn: requestIds)
              .get();

          _requests = requestSnapshots.docs.map((doc) => RequestModel.fromMap(doc.data())).toList();
          notifyListeners();
        }
      }
    } catch (error) {
      print("Error fetching requests: $error");
    }
  }






  /// Add a new Request and store the request ID in the client document
  Future<void> addRequest(String clientId, String clientName, String clientPhone, String issue, String details, String lawyerId) async {
    var uuid = Uuid();
    String requestId = uuid.v4();

    RequestModel newRequest = RequestModel(
      id: requestId,
      status: RequestStatus.Awaiting,
      lawyerId: lawyerId,
      clientId: clientId,
      formDetails: {
        'clientName': clientName,
        'phone': clientPhone,
        'issue': issue,
        'details': details,
      },
    );

    try {
      // Add request to "requests" collection
      await _firestore.collection('requests').doc(requestId).set(newRequest.toMap());

      // Update client document in a single operation
      await _firestore.collection('clients').doc(clientId).update({
        'requests': FieldValue.arrayUnion([requestId]),
        'profile.connectedLawyer': FieldValue.arrayUnion([lawyerId])
      });

      _requests.add(newRequest);
      notifyListeners();
    } catch (error) {
      print("Error adding request: $error");
    }
  }

  /// Update Request Status in Firestore
  Future<void> updateRequestStatus(String requestId, RequestStatus newStatus) async {
    try {

      String status = newStatus.name;
      // Update the request status in Firestore
      await _firestore.collection('requests').doc(requestId).update({
        'status': status,
      });

      // Find the request in the local list
      int index = _requests.indexWhere((request) => request.id == requestId);
      if (index != -1) {
        RequestModel updatedRequest = RequestModel(
          id: _requests[index].id,
          status: newStatus,
          lawyerId: _requests[index].lawyerId,
          clientId: _requests[index].clientId,
          formDetails: _requests[index].formDetails,
        );

        _requests[index] = updatedRequest;
        notifyListeners();

        // If request is resolved, add data to resolvedCases inside client's profile
        if (newStatus == RequestStatus.Resolve) {
          print("capital");
          String clientId = updatedRequest.clientId;

          Lawyer? lawyer;
          try {
            final DocumentSnapshot doc =
            await _firestore.collection('lawyers').doc(updatedRequest.lawyerId).get();
            if (doc.exists) {
              lawyer = Lawyer.fromMap(doc.data() as Map<String, dynamic>?);
            }
          } catch (error) {
            print("Error fetching lawyer by ID: $error");
          }

          String lawyerName = lawyer!.firstName;
          String? issue = updatedRequest.formDetails['issue'];
          String? domain = lawyer.profile?.selectedDomains[0];

          Map<String, dynamic> resolvedCaseData = {
            'domain': domain,
            'issue': issue,
            'lawyerName': lawyerName,
            'rating': 0, // Default rating, user can update later
            'review': '',
          };

          await _firestore.collection('clients').doc(clientId).update({
            'profile.resolvedCases': FieldValue.arrayUnion([resolvedCaseData])
          });
        }
      }
    } catch (error) {
      print("Error updating request status: $error");
    }
  }

  /// Remove Request from Firestore and the client's requests array
  Future<void> removeRequest(String clientId, String requestId) async {
    try {
      // Remove request from "requests" collection
      await _firestore.collection('requests').doc(requestId).delete();

      // Remove request ID from the client's requests array
      await _firestore.collection('clients').doc(clientId).update({
        'requests': FieldValue.arrayRemove([requestId])
      });

      _requests.removeWhere((request) => request.id == requestId);
      notifyListeners();
    } catch (error) {
      print("Error removing request: $error");
    }
  }

  /// Clear All Requests from Firestore for a Client
  Future<void> clearRequests(String clientId) async {
    try {
      final clientDoc = await _firestore.collection('clients').doc(clientId).get();
      if (!clientDoc.exists || !clientDoc.data()!.containsKey('requests')) return;

      List<String> requestIds = List<String>.from(clientDoc['requests']);

      // Delete each request from "requests" collection
      for (String requestId in requestIds) {
        await _firestore.collection('requests').doc(requestId).delete();
      }

      // Remove all request IDs from the client document
      await _firestore.collection('clients').doc(clientId).update({'requests': []});

      _requests.clear();
      notifyListeners();
    } catch (error) {
      print("Error clearing requests: $error");
    }
  }
}
