import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/lawyer.dart';
import '../../providers/lawyer_provider.dart';
import './request/apply_for_request_screen.dart';

class RequestScreen extends StatelessWidget {
  final requestProvider = Provider.of<RequestProvider>(context);
  final requests = requestProvider.requests;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: requests.isNotEmpty
          ? ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                request.lawyerName,
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Issue: ${request.issue}"),
                  Text("Details: ${request.details}"),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplyForRequestScreen(request.lawyerId),
                  ),
                );
              },
            ),
          );
        },
      )
          :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Transform.rotate(
                  angle: -pi / 4, // Rotates the icon 45 degrees upward
                  child: Icon(Icons.send, size: 100, color: Color(0xFFDAE5E2)),
                ),
                SizedBox(height: 40),
                Text(
                  "You will see your\nrequests here",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                    // Navigate to the new page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Padding(
                              padding: EdgeInsets.all(10),
                              child: LawyerListScreen())),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                    backgroundColor: Color(0xFF6D4905), // Brown color
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Less rounded corners
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // This will ensure the button size fits the content
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
                      Text("Add New Request"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LawyerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the list of filtered lawyers from the provider
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
                // Call the filterLawyers method when the search text changes
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lawyer.domain,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              lawyer.rating,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Show the profile details dialog
                      showProfileDetail(context, lawyer);
                    },
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No matches found.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show the profile detail dialog
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
                    CircleAvatar(radius: 30, backgroundImage: AssetImage(lawyer.image)),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lawyer.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(lawyer.domain, style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(lawyer.rating, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                        builder: (context) => ApplyForRequestScreen(lawyer.id),
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