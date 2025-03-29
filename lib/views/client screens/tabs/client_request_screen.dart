import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/views/client%20screens/tabs/request/client_request_detail_screen.dart';
import './request/case_detail_overview_screen.dart';
import 'package:provider/provider.dart';
import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../../../providers/lawyer_provider.dart';
import '../../../providers/request_provider.dart';
import './request/apply_for_request_screen.dart';
import 'request/lawyer_list_screen.dart';

class ClientRequestScreen extends StatefulWidget {
  @override
  State<ClientRequestScreen> createState() => _ClientRequestScreenState();
}

class _ClientRequestScreenState extends State<ClientRequestScreen> {
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
      case RequestStatus.Resolve:
        return Color(0xFF7483E8);
      default:
        return Colors.black;
    }
  }



  @override
  void initState() {

    fetchRequestData();
    // TODO: implement initState
    super.initState();
  }
  Future<void> _refreshRequests() async {
    final requestProvider = Provider.of<RequestProvider>(context, listen: false);
    await requestProvider.fetchRequests();
  }


  void fetchRequestData(){
    final requestProvider = Provider.of<RequestProvider>(context,listen: false);
    requestProvider.fetchRequests();

  }

  Future<Lawyer?> getLawyer(RequestModel request) async {
    final lawyerProvider = Provider.of<LawyerProvider>(context,listen: false);


    return await lawyerProvider.getLawyerById(request.lawyerId);
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
          ?RefreshIndicator(
        onRefresh: _refreshRequests,
            child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
            final request = requests[index];
            final statusText = request.status.toString().split('.').last;


            return FutureBuilder<Lawyer?>(

              future: getLawyer(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Show loading indicator
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No lawyer found"));
                }

                Lawyer lawyer = snapshot.data!; // Lawyer object from FutureBuilder

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientRequestDetailScreen(request: request),
                      ),
                    );
                  },
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
                                "Request # ${lawyer.id}",
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
                              "Case Domain: ${lawyer.profile != null && lawyer.profile!.selectedDomains.isNotEmpty ? lawyer.profile!.selectedDomains[0] : "N/A"}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),

                          Text(
                            "Lawyer: ${lawyer.firstName}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                            ),
                          ),

                          Text("Issue: ${request.formDetails['issue']}"),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
                    },
                  ),
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

