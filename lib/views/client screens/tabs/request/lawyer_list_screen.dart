import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/lawyer.dart';
import '../../../../providers/lawyer_provider.dart';
import 'apply_for_request_screen.dart';



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
                        builder: (context) => ClientApplyForRequestScreen(lawyer.id),
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
