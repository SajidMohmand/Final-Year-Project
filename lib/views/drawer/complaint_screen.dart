import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/complaint_provider.dart';
import 'complaint/ClientListScreen.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  Set<String> expandedComplaints = {}; // Track expanded complaints

  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    final complaints = complaintProvider.complaints;

    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints"),
      ),
      body: complaints.isNotEmpty
          ? ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          bool isExpanded = expandedComplaints.contains(complaint.id);

          return Container(
            width: 328,
            margin: EdgeInsets.only(bottom: 10),
            child: Card(
              color: Colors.brown.shade100,
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Complaint Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded( // Prevents overflow
                          child: Text(
                            "Complaint # ${complaint.id}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis, // Adds "..." if text is too long
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    Divider(thickness: 0.5, color: Colors.black),

                    // Expanded Complaint Details
                    if (isExpanded) ...[
                      SizedBox(height: 10),
                      Text(
                        "Respondent: ${complaint.respondentDetails.name ?? 'Unknown'}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Phone: ${complaint.respondentDetails ?? 'N/A'}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Issue: ${complaint.complaintDetails['issue'] ?? 'No issue provided'}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Details: ${complaint.complaintDetails['details'] ?? 'No details available'}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),

                      // Cancel Button to Hide Details
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              expandedComplaints.remove(complaint.id);
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    ],

                    // "See Details" Button (Only if Not Expanded)
                    if (!isExpanded)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (expandedComplaints.contains(complaint.id)) {
                                expandedComplaints.remove(complaint.id);
                              } else {
                                expandedComplaints.add(complaint.id);
                              }
                            });
                          },

                          style: TextButton.styleFrom(
                            foregroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: Text(
                            "See Details",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -pi / 4,
              child: Icon(Icons.report, size: 100, color: Color(0xFFDAE5E2)),
            ),
            SizedBox(height: 40),
            Text(
              "No complaints yet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Submit a complaint to get assistance",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientListScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
