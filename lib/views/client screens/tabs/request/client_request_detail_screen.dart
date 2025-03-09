import 'package:flutter/material.dart';
import 'package:fyp2/views/lawyer%20screens/profile_view_screen.dart';
import 'package:provider/provider.dart';
import '../../../../models/request.dart';
import '../../../../providers/request_provider.dart';

class ClientRequestDetailScreen extends StatelessWidget {
  final RequestModel request;

  ClientRequestDetailScreen({required this.request});

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
                    Text("Request ID: ${request.client.id}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(request.status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        request.status.toString().split('.').last,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                Divider(),

                // Case Domain
                Center(child: Text("Phone", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
                Center(child: Text(request.lawyer.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),

                Divider(),

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Lawyer",style: TextStyle(fontWeight: FontWeight.w400),)),
                ListTile(
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileViewScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(request.lawyer.image),
                    ),
                  ),
                  title: Text(request.lawyer.name, style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(request.lawyer.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      // chat logic
                    },
                  ),
                ),

                Divider(),

                // Case Details
                Text("Case Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                SizedBox(height: 8),

                Center(child: Text("Issue")),
                Center(child: Text("${request.formDetails['issue']}",style: TextStyle(fontWeight: FontWeight.w600),)),

                SizedBox(height: 15),

                Center(child: Text("Case Description")),
                Center(child: Text("${request.formDetails['details']}",style: TextStyle(fontWeight: FontWeight.w600),)),

                if (request.formDetails['attachment'] != null)
                  TextButton(
                    onPressed: () {
                      // Open Attachment
                    },
                    child: Text("View Attachment", style: TextStyle(color: Colors.blue)),
                  ),
                if(request.formDetails['attachment'] == null)
                  Center(child: Text("!No Evidence Attach")),
                SizedBox(height: 8),

                Spacer(),


              ],
            ),
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
      default:
        return Colors.black;
    }
  }
}
