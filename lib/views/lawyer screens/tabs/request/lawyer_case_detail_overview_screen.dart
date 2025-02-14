import 'package:flutter/material.dart';
import 'package:fyp2/models/lawyer.dart';
import 'package:fyp2/providers/lawyer_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/form_provider.dart';
import '../../../../providers/request_provider.dart';

class LawyerCaseDetailOverviewScreen extends StatelessWidget {


  final String id;
  final String name;
  final String phone;
  final String issue;
  final String details;

  LawyerCaseDetailOverviewScreen(this.id,this.name, this.phone, this.issue, this.details);


  @override
  Widget build(BuildContext context) {
    final lawyer = Provider.of<LawyerProvider>(context).getLawyerById(id);
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
                color: Colors.brown.withValues(alpha: 0.1),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLawyerProfile(lawyer!),
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

            Provider.of<FormProvider>(context, listen: false)
                .saveFormDetails(name, phone, issue, details);

            final lawyer = Provider.of<LawyerProvider>(context,listen: false).getLawyerById(id);
            Provider.of<RequestProvider>(context, listen: false).addRequest(name, phone, issue, details,lawyer!);


            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                Future.delayed(Duration(seconds: 2), () {
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();

                      if (context.mounted) {
                        for(int i=0; i<3; i++){
                          Navigator.of(context).pop();
                        }
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
                          "Request sent successfully",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
          child: Text("Send Request", style: TextStyle(color: Colors.white)),
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
  Widget _buildLawyerProfile(Lawyer lawyer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lawyer Details",
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
                  lawyer.image,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 40, color: Colors.grey[600]);
                  },
                ),
              ),
            ),

            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lawyer.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  lawyer.domain,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text(lawyer.rating.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
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
        _buildDetailRow("Cyber Issue", issue),
        _buildIncidentDetailRow("Incident Details", details),
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
          Text(value, style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),
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
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left: 5,right: 5),
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
