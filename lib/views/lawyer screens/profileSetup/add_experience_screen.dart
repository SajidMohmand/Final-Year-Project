import 'package:flutter/material.dart';

import 'basic_info_screen.dart';

class AddExperienceScreen extends StatefulWidget {
  @override
  _AddExperienceScreenState createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  List<Map<String, TextEditingController>> experiences = [
    {
      "title": TextEditingController(),
      "company": TextEditingController(),
      "location": TextEditingController(),
      "startDate": TextEditingController(),
      "endDate": TextEditingController(),
    }
  ];

  void addExperience() {
    setState(() {
      experiences.add({
        "title": TextEditingController(),
        "company": TextEditingController(),
        "location": TextEditingController(),
        "startDate": TextEditingController(),
        "endDate": TextEditingController(),
      });
    });
  }

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
              // Title
              Text(
                "Add Experience (optional)",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              Text(
                "Start with the latest job details",
                style: TextStyle(fontSize: 14, color: Color(0xff6F7977), fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),

              // Experience Fields
              ...experiences.map((exp) {
                int index = experiences.indexOf(exp);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    TextField(
                      controller: exp["title"],
                      decoration: InputDecoration(
                        labelText: "Job Title",
                        filled: true,
                        fillColor: Colors.brown.shade100,

                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: exp["company"],
                      decoration: InputDecoration(
                        labelText: "Company / Organization",
                        filled: true,
                        fillColor: Colors.brown.shade100,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: exp["location"],
                      decoration: InputDecoration(
                        labelText: "Location",
                        filled: true,
                        fillColor: Colors.brown.shade100,
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: null,
                      onChanged: (value) {
                        exp["startDate"]?.text = value.toString();
                      },
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        filled: true,
                        fillColor: Colors.brown.shade100,
                      ),
                      items: List.generate(50, (index) => 1980 + index) // Generates years from 1980 to 2029
                          .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      ))
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: null,
                      onChanged: (value) {
                        exp["endDate"]?.text = value.toString();
                      },
                      decoration: InputDecoration(
                        labelText: "End Date",
                        filled: true,
                        fillColor: Colors.brown.shade100,
                      ),
                      items: List.generate(50, (index) => 1980 + index)
                          .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      ))
                          .toList(),
                    ),

                    if (index != experiences.length - 1) Divider(height: 30),
                  ],
                );
              }).toList(),

              SizedBox(height: 20),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2), // Black border
                    borderRadius: BorderRadius.circular(8), // Same border radius as the button
                  ),
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: addExperience,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Add Another Experience",
                        style: TextStyle(fontSize: 16,color: Colors.brown),
                      ),
                    ),
                  ),
                ),
              ),



              SizedBox(height: 30),

              // Skip and Next Buttons
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
                            MaterialPageRoute(builder: (context) => BasicInfoScreen()),
                          );},
                        child: Text("Skip", style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BasicInfoScreen()),
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
