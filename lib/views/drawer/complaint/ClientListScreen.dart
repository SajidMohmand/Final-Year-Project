import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/client_provider.dart';
import '../../../models/client.dart';
import './complaint_detail_overview_screen.dart';
import 'lawyer_apply_for_complaint_screen.dart'; // Import client detail screen

class ClientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final clients = clientProvider.filteredClients;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Clients"),
      ),
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your Valued Clients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: clients.isNotEmpty
                ? ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(client.image),
                    ),
                    title: Text(
                      client.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.phone,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[700]),
                        ),
                        Row(
                          children: [
                            Icon(Icons.description,
                                color: Colors.blue, size: 18),
                            SizedBox(width: 4),

                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      showClientDetail(context, client);
                    },
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No matches found.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showClientDetail(BuildContext context, Client client) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Client Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 30, backgroundImage: AssetImage(client.image)),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(client.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(client.phone, style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Icon(Icons.description, color: Colors.blue, size: 18),
                            SizedBox(width: 4),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black),
                SizedBox(height: 10),

                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LawyerApplyForComplaintScreen(client.id),
                      ),
                    );
                  },
                  child: Text("Apply for Complaint"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
