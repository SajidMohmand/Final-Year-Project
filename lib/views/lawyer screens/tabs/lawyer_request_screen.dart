import 'dart:math';
import 'package:flutter/material.dart';
import './request/lawyer_case_detail_overview_screen.dart';
import 'package:provider/provider.dart';
import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../../../providers/lawyer_provider.dart';
import '../../../providers/request_provider.dart';
import './request/lawyer_apply_for_request_screen.dart';

class LawyerRequestScreen extends StatelessWidget {
  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.Accepted:
        return Color(0xff72F7EA);
      case RequestStatus.Awaiting:
        return Color(0xffFFE08E);
      case RequestStatus.Declined:
        return Color(0xffDE3730);
      case RequestStatus.Timeout:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    final requests = requestProvider.requests;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Requests"),
      ),

      body: requests.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                final statusText = request.status.toString().split('.').last;

                return Container(
                  width: 328,
                  height: 214,
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.brown.shade100,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request # ${request.lawyer.id}",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                                ),
                                Container(
                                  height: 24,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(request.status),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  child: Center(
                                    child: Text(
                                      statusText,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            Text(
                              "Case Domain: ${request.lawyer.domain}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),

                            Text(
                              "Lawyer: ${request.lawyer.name}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.25,
                              ),
                            ),

                            Text("Issue: ${request.formDetails['issue']}"),
                            SizedBox(height: 12),

                            if (request.status == RequestStatus.Accepted) ...[
                              Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LawyerCaseDetailOverviewScreen(
                                            request.lawyer.id,
                                            request.formDetails['name'].toString(),
                                            request.formDetails['phone'].toString(),
                                            request.formDetails['issue'].toString(),
                                            request.formDetails['details'].toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                    ),
                                    child: Text(
                                      "See Details",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7.0),
                                      ),
                                    ),
                                    child: Text(
                                      "Chat",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Transform.rotate(
                        angle: -pi / 4,
                        child: Icon(Icons.send,
                            size: 100, color: Color(0xFFDAE5E2)),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "You will see your\nrequests here",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Find Lawyer for your case by sending request",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Padding(
                                    padding: EdgeInsets.all(10),
                                    child: LawyerListScreen())),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Color(0xFF6D4905),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(
                                width:
                                    8),
                            Text("Add New Request"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Padding(
                    padding: EdgeInsets.all(10), child: LawyerListScreen())),
          );
        },
        backgroundColor: Colors.brown.shade500,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class LawyerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lawyerProvider = Provider.of<LawyerProvider>(context);
    final lawyers = lawyerProvider.filteredLawyers;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Lawyers"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                lawyerProvider.filterLawyers(query);
              },
              decoration: InputDecoration(
                labelText: "Search Lawyers",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Top Lawyers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: lawyers.isNotEmpty
                ? ListView.builder(
                    itemCount: lawyers.length,
                    itemBuilder: (context, index) {
                      final lawyer = lawyers[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(lawyer.image),
                          ),
                          title: Text(
                            lawyer.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lawyer.domain,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    lawyer.rating,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            showProfileDetail(context, lawyer);
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

  void showProfileDetail(BuildContext context, Lawyer lawyer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Lawyer Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 30, backgroundImage: AssetImage(lawyer.image)),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lawyer.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(lawyer.domain, style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(lawyer.rating,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Chat"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("View Complete Profile"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LawyerApplyForRequestScreen(lawyer.id),
                      ),
                    );
                  },
                  child: Text("Apply for Request"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
