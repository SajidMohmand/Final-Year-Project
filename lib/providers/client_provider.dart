import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/client.dart';
import '../models/client_profile.dart';
import '../models/request.dart';

class ClientProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Client> _clients = [];

  List<Client> get clients => [..._clients];

  List<Client> _filteredClients = [];

  List<Client> get filteredClients =>
      _filteredClients.isEmpty ? _clients : _filteredClients;

  // Fetch clients from Firestore
  Future<void> fetchClients() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('clients').get();
      _clients = snapshot.docs.map((doc) {
        return Client.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching clients: $error");
    }
  }

  // Get client by ID from Firestore
  Future<Client?> getClientById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('clients').doc(id).get();

      if (!doc.exists) {
        print("Client document does not exist.");
        return null;
      }

      var data = doc.data() as Map<String, dynamic>?;

      if (data == null) {
        print("Firestore document exists but has no data.");
        return null;
      }

      // Extract request IDs safely
      List<String> requestIds = data.containsKey('requests') && data['requests'] != null
          ? List<String>.from(data['requests'])
          : [];

      // Fetch request documents based on request IDs
      List<RequestModel> requestList = [];

      if (requestIds.isNotEmpty) {
        try {
          var requestSnapshots = await _firestore
              .collection('requests')
              .where(FieldPath.documentId, whereIn: requestIds)
              .get();

          requestList = requestSnapshots.docs
              .map((doc) => RequestModel.fromMap(doc.data()))
              .toList();
        } catch (error) {
          print("Error fetching requests: $error");
        }
      }

      // Create and return the Client object with requests
      return Client.fromMap({
        ...data,
        'requests': requestList, // Assign the fetched request objects
      });

    } catch (error) {
      print("Error fetching client by ID: $error");
      return null;
    }
  }


  // Add a new client
  Future<void> addClient(Client client) async {
    try {
      await _firestore.collection('clients').doc(client.id).set(client.toMap());
      _clients.add(client);
      notifyListeners();
    } catch (error) {
      print("Error adding client: $error");
    }
  }

  // Delete a client
  Future<void> deleteClient(String id) async {
    try {
      await _firestore.collection('clients').doc(id).delete();
      _clients.removeWhere((client) => client.id == id);
      notifyListeners();
    } catch (error) {
      print("Error deleting client: $error");
    }
  }

  // **Update Client Profile in Firestore**
  Future<void> updateClientProfile(String clientId, ClientProfile updatedProfile) async {
    try {
      await _firestore.collection('clients').doc(clientId).update({
        'profile': updatedProfile.toMap(),
      });

      // Update locally
      int index = _clients.indexWhere((client) => client.id == clientId);
      if (index != -1) {
        _clients[index] = Client(
          id: _clients[index].id,
          firstName: _clients[index].firstName,
          lastName: _clients[index].lastName,
          phone: _clients[index].phone,
          email: _clients[index].email,
          image: _clients[index].image,
          complaintNum: _clients[index].complaintNum,
          profile: updatedProfile, // Update profile field
        );
        notifyListeners();
      }
    } catch (error) {
      print("Error updating client profile: $error");
    }
  }



  Future<List<Map<String, String>>?> getResolvedCases() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? clientId = auth.currentUser?.uid;
    try {
      DocumentSnapshot doc = await _firestore.collection('clients').doc(clientId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Extract 'profile' field
        Map<String, dynamic>? profile = data['profile'] as Map<String, dynamic>?;

        if (profile != null && profile.containsKey('resolveCases')) {
          List<dynamic> resolveCasesList = profile['resolveCases'];

          // Ensure the list contains maps
          return resolveCasesList.cast<Map<String, String>>();
        }
      }
      return null; // Return null if no data found
    } catch (error) {
      print("Error fetching resolved cases: $error");
      return null;
    }
  }

  Future<List<Map<String, String>>> fetchConnectedLawyers() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? userId = auth.currentUser?.uid;

    if (userId == null) return []; // Return empty list if no user

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch client document
      DocumentSnapshot clientSnapshot =
      await firestore.collection('clients').doc(userId).get();

      if (!clientSnapshot.exists) return []; // Return empty list if client doesn't exist

      // Extract connectedLawyer IDs
      List<dynamic>? lawyerIds = clientSnapshot['profile']?['connectedLawyer'];

      if (lawyerIds == null || lawyerIds.isEmpty) return []; // Return empty list if no lawyers connected

      List<Map<String, String>> lawyerList = [];

      // Fetch all lawyers in one go using a batch query
      QuerySnapshot lawyerSnapshot = await firestore
          .collection('lawyers')
          .where(FieldPath.documentId, whereIn: lawyerIds)
          .get();

      for (var doc in lawyerSnapshot.docs) {
        lawyerList.add({
          "id": doc.id,
          "name": doc["name"], // Add other fields if needed
        });
      }

      return lawyerList;
    } catch (e) {
      print("Error fetching connected lawyers: $e");
      return [];
    }
  }



}
