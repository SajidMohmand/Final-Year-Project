import 'package:flutter/material.dart';
import '../models/client.dart';

class ClientProvider with ChangeNotifier {
  final List<Client> _clients = [
    Client(
      id: "1",
      name: "Ahmed Khan",
      phone: "03001213322",
      image: "assets/images/lawyer1.png",
      complaintNum: 0,
    ),
    Client(
      id: "2",
      name: "Sara Ali",
      phone: "03001213322",
      image: "assets/images/lawyer2.png",
      complaintNum: 0,
    ),
    Client(
      id: "3",
      name: "Usman Tariq",
      phone: "03001213322",
      image: "assets/images/lawyer3.png",
      complaintNum: 0,
    ),
    Client(
      id: "4",
      name: "Ayesha Noor",
      phone: "03001213322",
      image: "assets/images/lawyer4.png",
      complaintNum: 0,
    ),
    Client(
      id: "5",
      name: "Hassan Raza",
      phone: "03001213322",
      image: "assets/images/lawyer1.png",
      complaintNum: 0,
    ),
  ];

  List<Client> get clients => [..._clients];

  List<Client> _filteredClients = [];

  List<Client> get filteredClients =>
      _filteredClients.isEmpty ? _clients : _filteredClients;



  Client? getClientById(String id) {
    return _clients.firstWhere(
          (client) => client.id == id,
      orElse: () => Client(
        id: "",
        name: "Unknown",
        phone: "03001213322",
        image: "assets/images/client1.png",
        complaintNum: 0,
      ),
    );
  }
}
