import 'package:flutter/material.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'add_experience_screen.dart';

class BioSetupScreen extends StatefulWidget {
  @override
  _BioSetupScreenState createState() => _BioSetupScreenState();
}

class _BioSetupScreenState extends State<BioSetupScreen> {
  late TextEditingController bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedMasterField;
  String? selectedMasterUniversity;
  String? selectedMasterYear;
  String? selectedBachelorField;
  String? selectedBachelorUniversity;
  String? selectedBachelorYear;

  @override
  void initState() {
    super.initState();
  }

  void saveData() {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    profileProvider.updateController(bioController);

    if (selectedMasterField != null &&
        selectedMasterUniversity != null &&
        selectedMasterYear != null) {
      profileProvider.updateMasterEducation(
        selectedMasterField!, selectedMasterUniversity!, selectedMasterYear!,
      );
    }

    if (selectedBachelorField != null &&
        selectedBachelorUniversity != null &&
        selectedBachelorYear != null) {
      profileProvider.updateBachelorEducation(
        selectedBachelorField!, selectedBachelorUniversity!, selectedBachelorYear!,
      );
    }
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Specify Bio", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                SizedBox(height: 10),
                TextFormField(
                  controller: bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter your bio...",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.brown.shade100,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Bio is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),

                Text("Add Education", style: TextStyle(fontSize: 22)),
                SizedBox(height: 20),

                Text("1. Master Level (optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 7),
                DropdownButtonFormField<String>(
                  value: selectedMasterField,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "Master / MPhil in..."),
                  items: fields.map((field) => DropdownMenuItem(value: field, child: Text(field))).toList(),
                  onChanged: (value) => setState(() => selectedMasterField = value),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedMasterUniversity,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "College / University"),
                  items: universities.map((uni) => DropdownMenuItem(value: uni, child: Text(uni))).toList(),
                  onChanged: (value) => setState(() => selectedMasterUniversity = value),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedMasterYear,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "Posting Year"),
                  items: years.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
                  onChanged: (value) => setState(() => selectedMasterYear = value),
                ),
                SizedBox(height: 40),

                Text("2. Bachelor Level Education", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 7),
                DropdownButtonFormField<String>(
                  value: selectedBachelorField,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "Bachelor in..."),
                  items: fields.map((field) => DropdownMenuItem(value: field, child: Text(field))).toList(),
                  onChanged: (value) => setState(() => selectedBachelorField = value),
                  validator: (value) => value == null ? 'Bachelor field is required' : null,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedBachelorUniversity,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "College / University"),
                  items: universities.map((uni) => DropdownMenuItem(value: uni, child: Text(uni))).toList(),
                  onChanged: (value) => setState(() => selectedBachelorUniversity = value),
                  validator: (value) => value == null ? 'Bachelor university is required' : null,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedBachelorYear,
                  decoration: InputDecoration(filled: true, fillColor: Colors.brown.shade100, hintText: "Posting Year"),
                  items: years.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
                  onChanged: (value) => setState(() => selectedBachelorYear = value),
                  validator: (value) => value == null ? 'Bachelor year is required' : null,
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
                            saveData();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => AddExperienceScreen()),
                            );
                          },
                          child: Text("Skip", style: TextStyle(fontSize: 18, color: Colors.brown)),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveData();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => AddExperienceScreen()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
