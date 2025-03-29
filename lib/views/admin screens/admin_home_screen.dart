import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/complaint_provider.dart';
import '../../models/complaint.dart';
import '../../widgets/app_drawer.dart';
import '../login/login_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}


class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    final complaints = complaintProvider.complaints;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Allow avatar to overflow the container
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.27, // Increased height
                  decoration: BoxDecoration(
                    color: Colors.brown, // Background color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 155, // Keep same position
                  left: 110,
                  child: Container(
                    width: 83,
                    height: 83,
                    child: CircleAvatar(
                      radius: 40, // Adjust size
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 38, // Slightly smaller for a border effect
                        backgroundImage: AssetImage("assets/images/splash.png"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 240, // Keep same position
                  left: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Legal Right Awareness",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 80), // Increased space below to avoid overlap

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Padding(
                          padding: EdgeInsets.all(10),
                          child: LoginScreen())),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: complaints.isEmpty
          ? const Center(
        child: Text("No Complaints", style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintDetailScreen(complaint: complaint),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0) // Show ID only for the first complaint
                      Text(
                        "Complaint ID: ${complaint.id}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        complaint.status == ComplaintStatus.Resolved ? "Status: Resolved" : "Status: Waiting",
                        style: TextStyle(
                          color: complaint.status == ComplaintStatus.Resolved ? Colors.red : Colors.green,
                          fontSize: 14
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),



                    // Complainant Name
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Complainant: ${complaint.complainantDetails.firstName ?? 'Unknown'}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Respondent Name
                    Row(
                      children: [
                        const Icon(Icons.person_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Respondent: ${complaint.respondentDetails.firstName ?? 'Unknown'}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Issue Description
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Issue: ${complaint.complaintDetails['issue'] ?? 'No issue specified'}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Navigation Arrow
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}


class ComplaintDetailScreen extends StatelessWidget {
  final Complaint complaint;

  ComplaintDetailScreen({required this.complaint});



  void showComplaintDialog(BuildContext context,String str) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        Future.delayed(Duration(seconds: 2), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
          Navigator.pop(context);
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
                  str,
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint Details"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Complaint Number:${complaint.complaintNum.toString()}",
              style: TextStyle(fontSize: 13),),
              const SizedBox(height: 12),


              Center(child: Text(complaint.status.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.green),),),



              // Complainant Details
              _buildDetailCard(
                title: "Complainant Details",
                details: {"name" : complaint.complainantDetails.firstName,
                "domain" : complaint.complainantDetails.profile!.selectedDomains[0],
                "rating" : complaint.complainantDetails.rating.toString(),
                },
                icon: Icons.person,
                color: Colors.blue,
              ),
              const SizedBox(height: 12),

              // Respondent Details
              _buildDetailCard(
                title: "Respondent Details",
                details: {"name": complaint.respondentDetails.firstName,
                "phone" : complaint.respondentDetails.phone},
                icon: Icons.person_outline,
                color: Colors.red,
              ),
              const SizedBox(height: 12),

              // Complaint Details
              _buildDetailCard(
                title: "Complaint Details",
                details: complaint.complaintDetails,
                icon: Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
              const SizedBox(height: 12),

              // Attachments
              if (complaint.complaintDetails.containsKey('file'))
                _buildAttachmentCard(complaint.complaintDetails['file']!),


              if (complaint.status == ComplaintStatus.Waiting) ...[
                if (complaint.complaintNum == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              complaint.updateStatus(ComplaintStatus.Resolved);
                              showComplaintDialog(context, "Complaint Request Declined successfully");
                            },
                            child: Text("Decline", style: TextStyle(fontSize: 18, color: Colors.brown)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            complaint.updateStatus(ComplaintStatus.Resolved);
                            showComplaintDialog(context, "Warning sent successfully");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Send Warning", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),

                if (complaint.complaintNum == 1)
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        complaint.updateStatus(ComplaintStatus.Resolved);
                        showComplaintDialog(context, "User Blocked successfully");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Block User", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
              ],
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  // Common Card Builder
  Widget _buildDetailCard({
    required String title,
    required Map<String, String> details,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ...details.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "${entry.key}: ${entry.value}",
                style: const TextStyle(fontSize: 16),
              ),
            )),
          ],
        ),
      ),
    );
  }

  // Attachment Card
  Widget _buildAttachmentCard(String filePath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.attach_file, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Attachment: $filePath",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.download, color: Colors.blue),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
