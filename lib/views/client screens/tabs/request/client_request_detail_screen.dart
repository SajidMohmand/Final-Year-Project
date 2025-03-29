import 'package:flutter/material.dart';
import 'package:fyp2/providers/lawyer_provider.dart';
import 'package:fyp2/views/lawyer%20screens/profile_view_screen.dart';
import 'package:provider/provider.dart';
import '../../../../models/lawyer.dart';
import '../../../../models/request.dart';
import '../../../../providers/request_provider.dart';

class ClientRequestDetailScreen extends StatefulWidget {
  final RequestModel request;

  ClientRequestDetailScreen({required this.request});

  @override
  State<ClientRequestDetailScreen> createState() => _ClientRequestDetailScreenState();
}

class _ClientRequestDetailScreenState extends State<ClientRequestDetailScreen> {

  Lawyer? lawyer;
  @override
  void initState() {

    fetchLawyer();
    // TODO: implement initState
    super.initState();
  }

  void fetchLawyer() async {
    final lawyerProvider = Provider.of<LawyerProvider>(context, listen: false);
    final fetchedLawyer = await lawyerProvider.getLawyerById(widget.request.lawyerId);

    if (mounted) {
      setState(() {
        lawyer = fetchedLawyer;
      });
    }
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
                Center(child: lawyer == null
                    ? CircularProgressIndicator() // Show loading until lawyer is fetched
                    :Text(lawyer!.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),

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
                    child: lawyer == null
                        ? CircularProgressIndicator() // Show loading until lawyer is fetched
                        :CircleAvatar(
                      backgroundImage: AssetImage(lawyer!.image),
                    ),
                  ),
                  title: lawyer == null
                      ? CircularProgressIndicator() // Show loading until lawyer is fetched
                      :Text(lawyer!.firstName, style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: lawyer == null
                      ? CircularProgressIndicator() // Show loading until lawyer is fetched
                      :Text(lawyer!.phone),
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
                if(widget.request.formDetails['attachment'] == null)
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
      case RequestStatus.Resolve:
        return Color(0xFF7483E8);
      default:
        return Colors.black;
    }
  }
}
