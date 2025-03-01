import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lawyer_home_screen.dart';
import 'package:fyp2/providers/profile_provider.dart';

class SelectDomainScreen extends StatefulWidget {
  @override
  _SelectDomainScreenState createState() => _SelectDomainScreenState();
}

class _SelectDomainScreenState extends State<SelectDomainScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> allDomains = ["Cyber Law", "Intellectual Property", "Human Rights", "Corporate Law", "Criminal Law"];
  List<String> filteredDomains = [];

  @override
  void initState() {
    super.initState();
    filteredDomains = List.from(allDomains);
  }

  void filterDomains(String query) {
    setState(() {
      filteredDomains = allDomains
          .where((domain) => domain.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    List<String> selectedDomains = profileProvider.selectedDomains;

    return Scaffold(
      appBar: AppBar(title: Text("Select Domain")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Speciality domain", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),

            // Search Field
            TextField(
              controller: searchController,
              onChanged: filterDomains,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.brown.shade100,
                labelText: "Search Domain",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),

            // Domain List
            Expanded(
              child: ListView.builder(
                itemCount: filteredDomains.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredDomains[index]),
                    trailing: Icon(Icons.add, color: Colors.green),
                    onTap: () {
                      if (!selectedDomains.contains(filteredDomains[index])) {
                        selectedDomains.add(filteredDomains[index]);
                        profileProvider.updateDomains(selectedDomains);
                      }
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Selected Domains
            Wrap(
              spacing: 8,
              children: selectedDomains.map((domain) {
                return Chip(
                  backgroundColor: Colors.brown.shade100,
                  label: Text(domain),
                  deleteIcon: Icon(Icons.clear, size: 18, color: Colors.black),
                  onDeleted: () {
                    selectedDomains.remove(domain);
                    profileProvider.updateDomains(selectedDomains);
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 30),

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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LawyerHomeScreen()),
                        );
                      },
                      child: Text("Skip", style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedDomains.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select at least one domain."),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LawyerHomeScreen()),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
