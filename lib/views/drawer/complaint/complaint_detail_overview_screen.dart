import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp2/models/client.dart';
import 'package:fyp2/models/lawyer.dart';
import 'package:fyp2/providers/client_provider.dart';
import 'package:fyp2/providers/complaint_provider.dart';
import 'package:fyp2/providers/lawyer_provider.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/form_provider.dart';
import '../../../../providers/request_provider.dart';

class ComplaintDetailOverviewScreen extends StatelessWidget {
  final String id;
  final String name;
  final String phone;
  final String issue;
  final String details;
  File? selectedFile;

  ComplaintDetailOverviewScreen(
      this.id, this.name, this.phone, this.issue, this.details,this.selectedFile);

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).getClientById(id);

    return Scaffold(
      appBar: AppBar(title: Text("Review Request Details")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.brown.withOpacity(0.1),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildClientProfile(client!),
                      SizedBox(height: 20),
                      Divider(thickness: 1, color: Colors.grey),
                      SizedBox(height: 20),
                      _buildFormDetails(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildSendRequestButton(context),
        ],
      ),
    );
  }

  Widget _buildSendRequestButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 25),
        child: ElevatedButton(
          onPressed: () {
            Provider.of<FormProvider>(context, listen: false)
                .saveFormDetails(name, phone, issue, details);

            final client = Provider.of<ClientProvider>(context, listen: false)
                .getClientById(id);
            Provider.of<ComplaintProvider>(context, listen: false).fileComplaint(
              complainantType: "lawyer",
              complaintNum: client!.complaintNum,
              complainantDetails: Lawyer(
                id: "123",
                name: "jack smith",
                domain: "Cyber law",
                image: "assets/images/lawyer.png",
                rating: "4.1",
              ),
              respondentDetails: client!,
              complaintDetails: {
                "issue": issue,
                "details": details,
                "evidence": selectedFile != null ? selectedFile!.path : "",
              },
            );


            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                Future.delayed(Duration(seconds: 2), () {
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  if (context.mounted) {
                    for (int i = 0; i < 3; i++) {
                      Navigator.of(context).pop();
                    }
                  }
                });

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.brown, size: 50),
                        SizedBox(height: 15),
                        Text(
                          "Complaint sent to admin successfully",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                );
              },
            );
          },
          child: Text("Send Complaint", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: TextStyle(fontSize: 16),
            elevation: 5,
          ),
        ),
      ),
    );
  }

  Widget _buildClientProfile(Client client) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Client Details",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.asset(
                  client.image,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person,
                        size: 40, color: Colors.grey[600]);
                  },
                ),
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  client.phone,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow("Name", name),
        _buildDetailRow("Phone Number", phone),
        _buildDetailRow("Case Type", issue),
        _buildIncidentDetailRow("Case Details", details),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label ",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          Text(value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildIncidentDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
