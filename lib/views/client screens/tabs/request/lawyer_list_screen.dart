import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/lawyer.dart';
import '../../../../providers/lawyer_provider.dart';
import '../../../lawyer screens/profile_view_screen.dart';
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
                    leading:GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileViewScreen(),
                          ),
                        );
                      },

                      child: CircleAvatar(
                        backgroundImage: AssetImage(lawyer.image),
                      ),
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
                // Lawyer Information Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(lawyer.image),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lawyer.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade800,
                          ),
                        ),
                        Text(
                          lawyer.domain,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              lawyer.rating,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 12),
                Divider(color: Colors.grey.shade400, thickness: 1),
                SizedBox(height: 12),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Chat Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.chat, size: 18, color: Colors.white),
                      label: Text("Chat",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade700,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // View Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileViewScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.person, size: 18, color: Colors.white),
                      label: Text("View Profile",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade600,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Apply for Request Button
                SizedBox(
                  width: double.infinity, // Full-width button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientApplyForRequestScreen(lawyer.id),
                        ),
                      );
                    },
                    child: Text("Apply for Request", style: TextStyle(fontSize: 16,color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade900,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        );
      },
    );
  }
}
