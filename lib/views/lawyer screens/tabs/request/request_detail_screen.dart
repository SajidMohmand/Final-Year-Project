import 'package:flutter/material.dart';
import 'package:fyp2/models/client.dart';
import 'package:provider/provider.dart';
import '../../../../models/request.dart';
import '../../../../providers/client_provider.dart';
import '../../../../providers/request_provider.dart';

class RequestDetailScreen extends StatefulWidget {
  final RequestModel request;

  RequestDetailScreen({required this.request});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {

  Client? client;

  @override
  void initState() {
    fetchClient(widget.request);
    // TODO: implement initState
    super.initState();
  }
  void fetchClient(RequestModel request)async{
    client = await Provider.of<ClientProvider>(context,listen: false).getClientById(request.clientId);

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Request ID and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Request ID: ${widget.request.clientId}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.request.status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.request.status.toString().split('.').last,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                Divider(),

                // Case Domain
                Center(child: Text("Phone", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
                client == null? CircularProgressIndicator(): Center(child: Text(client!.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),

                Divider(),

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Client",style: TextStyle(fontWeight: FontWeight.w400),)),
                client == null? CircularProgressIndicator(): ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(client!.image),
                  ),
                  title: Text(client!.firstName, style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(client!.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      // Handle Chat Navigation
                    },
                  ),
                ),

                Divider(),

                // Case Details
                Text("Case Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                SizedBox(height: 8),

                Center(child: Text("Issue")),
                Center(child: Text("${widget.request.formDetails['issue']}",style: TextStyle(fontWeight: FontWeight.w600),)),

                SizedBox(height: 15),

                Center(child: Text("Case Description")),
                Center(child: Text("${widget.request.formDetails['details']}",style: TextStyle(fontWeight: FontWeight.w600),)),

                if (widget.request.formDetails['attachment'] != null)
                  TextButton(
                    onPressed: () {
                      // Open Attachment
                    },
                    child: Text("View Attachment", style: TextStyle(color: Colors.blue)),
                  ),
                SizedBox(height: 8),

                Spacer(),

                // Accept & Decline Buttons
                if (widget.request.status == RequestStatus.Awaiting)
                  Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle Decline
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Decreased border radius
                          ),
                        ),child: Text("Decline",),
                      ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<RequestProvider>(context, listen: false).updateRequestStatus(widget.request.id, RequestStatus.Accepted);

                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              Future.delayed(Duration(seconds: 2), () {
                                  Navigator.of(dialogContext).pop();
                                  Navigator.of(context).pop();
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
                                        "Request Accepted notification sent to the Client",
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown, // Brown background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Decreased border radius
                          ),
                        ),
                        child: Text(
                          "Accept Request",
                          style: TextStyle(color: Colors.white), // White text color
                        ),
                      ),

                    ),
                  ],
                ),
                if(widget.request.status == RequestStatus.Accepted)
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<RequestProvider>(context, listen: false).updateRequestStatus(widget.request.id, RequestStatus.Resolve);

                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(dialogContext).pop();
                                Navigator.of(context).pop();

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
                                      "Request Resolved notification sent to the Client",
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Decreased border radius
                        ),
                      ),child: Text("Resolved",style: TextStyle(color: Colors.white),),
                    ),
                  ),
              ],
            ),
          ),
        ),
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
            // Accepted, Awaiting, Declined, Timeout
            Provider.of<RequestProvider>(context, listen: false).updateRequestStatus(widget.request.id, "Accepted" as RequestStatus);

            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                Navigator.of(context).pop();

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
                          "Request Accepted notification sent to the Client",
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
}
