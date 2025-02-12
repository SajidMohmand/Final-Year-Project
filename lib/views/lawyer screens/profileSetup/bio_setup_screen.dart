import 'package:flutter/material.dart';
import 'add_experience_screen.dart';

class BioSetupScreen extends StatefulWidget {
  @override
  _BioSetupScreenState createState() => _BioSetupScreenState();
}

class _BioSetupScreenState extends State<BioSetupScreen> {
  final TextEditingController bioController = TextEditingController();

  String? selectedMasterField;
  String? selectedMasterUniversity;
  String? selectedMasterYear;
  String? selectedBachelorField;
  String? selectedBachelorUniversity;
  String? selectedBachelorYear;

  List<String> fields = ["Computer Science", "Engineering", "Business", "Medicine"];
  List<String> universities = ["Harvard", "Stanford", "MIT", "Oxford"];
  List<String> years = List.generate(50, (index) => (1975 + index).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setup Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Specify Bio Field
              Text("Specify Bio", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
              SizedBox(height: 10),
              TextField(
                controller: bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter your bio...",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
              SizedBox(height: 40),

              // Add Education
              Text("Add Education", style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              Text("1. Master Level (optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 7),

              DropdownButtonFormField<String>(
                value: selectedMasterField,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "Master / MPhil in...",
                ),
                items: fields.map((field) {
                  return DropdownMenuItem(value: field, child: Text(field));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMasterField = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedMasterUniversity,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "College / University",
                ),
                items: universities.map((uni) {
                  return DropdownMenuItem(value: uni, child: Text(uni));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMasterUniversity = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedMasterYear,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "Posting Year",
                ),
                items: years.map((year) {
                  return DropdownMenuItem(value: year, child: Text(year));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMasterYear = value;
                  });
                },
              ),
              SizedBox(height: 40),

              // Bachelor Level Education
              Text("2.Bachelor Level Education", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 7,),
              DropdownButtonFormField<String>(
                value: selectedBachelorField,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "Bachelor in...",
                ),
                items: fields.map((field) {
                  return DropdownMenuItem(value: field, child: Text(field));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBachelorField = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedBachelorUniversity,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "College / University",
                ),
                items: universities.map((uni) {
                  return DropdownMenuItem(value: uni, child: Text(uni));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBachelorUniversity = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedBachelorYear,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  hintText: "Posting Year",
                ),
                items: years.map((year) {
                  return DropdownMenuItem(value: year, child: Text(year));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBachelorYear = value;
                  });
                },
              ),
              SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Black border
                        borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AddExperienceScreen()),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(fontSize: 18, color: Colors.brown),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddExperienceScreen()),
                        );
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
            ],
          ),
        ),
      ),
    );
  }
}
