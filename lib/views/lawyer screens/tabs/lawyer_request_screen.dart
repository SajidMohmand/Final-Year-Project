import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fyp2/views/lawyer%20screens/tabs/request/request_detail_screen.dart';
import '../../../models/lawyer/lawyer_request.dart';
import 'package:provider/provider.dart';
import '../../../providers/lawyer/lawyer_request_provider.dart';

class LawyerRequestScreen extends StatefulWidget {
  @override
  State<LawyerRequestScreen> createState() => _LawyerRequestScreenState();
}

class _LawyerRequestScreenState extends State<LawyerRequestScreen> {
  Color _getStatusColor(LawyerRequestStatus status) {
    switch (status) {
      case LawyerRequestStatus.Accepted:
        return Color(0xff72F7EA);
      case LawyerRequestStatus.Awaiting:
        return Color(0xffFFE08E);
      case LawyerRequestStatus.Declined:
        return Color(0xffDE3730);
      case LawyerRequestStatus.Timeout:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<LawyerRequestProvider>(context);
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

                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestDetailScreen(request: request,),
                      ),
                    );
                  },
                  child: Container(
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
                                    "Request # ${request.client.id}",
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
                                "Phone: ${request.client.phone}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),

                              Text(
                                "Client: ${request.client.name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.25,
                                ),
                              ),

                              Text("Issue: ${request.formDetails['issue']}"),
                            ],
                          ),
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
                        "Currently you have recieved no requests by clients. Update you profile with your experience and qualifications to get more visibility.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),

                    ],
                  ),
                ),
              ],
            ),
      );
  }
}

