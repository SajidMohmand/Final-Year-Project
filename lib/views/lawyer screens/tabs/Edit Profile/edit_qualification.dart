import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp2/providers/profile_provider.dart';

class EditQualification extends StatefulWidget {
  @override
  _EditQualificationState createState() => _EditQualificationState();
}

class _EditQualificationState extends State<EditQualification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  TextEditingController masterFieldController = TextEditingController();
  TextEditingController masterUniversityController = TextEditingController();
  TextEditingController masterYearController = TextEditingController();
  TextEditingController bachelorFieldController = TextEditingController();
  TextEditingController bachelorUniversityController = TextEditingController();
  TextEditingController bachelorYearController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load existing qualification data from provider
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    var master = profileProvider.profile.education.firstWhere(
      (edu) => edu['level'] == 'Master',
      orElse: () => {},
    );
    var bachelor = profileProvider.profile.education.firstWhere(
      (edu) => edu['level'] == 'Bachelor',
      orElse: () => {},
    );

    masterFieldController.text = master['field'] ?? '';
    masterUniversityController.text = master['university'] ?? '';
    masterYearController.text = master['year'] ?? '';

    bachelorFieldController.text = bachelor['field'] ?? '';
    bachelorUniversityController.text = bachelor['university'] ?? '';
    bachelorYearController.text = bachelor['year'] ?? '';
  }

  @override
  void dispose() {
    masterFieldController.dispose();
    masterUniversityController.dispose();
    masterYearController.dispose();
    bachelorFieldController.dispose();
    bachelorUniversityController.dispose();
    bachelorYearController.dispose();
    super.dispose();
  }

  void saveData() {
    if (!_formKey.currentState!.validate()) return;

    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    profileProvider.addEducation(
      "Master",
      masterFieldController.text.trim(),
      masterUniversityController.text.trim(),
      masterYearController.text.trim(),
    );

    profileProvider.addEducation(
      "Bachelor",
      bachelorFieldController.text.trim(),
      bachelorUniversityController.text.trim(),
      bachelorYearController.text.trim(),
    );

    Navigator.pop(
        context, true); // Return to previous screen and trigger refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Qualification")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. Master Level (optional)",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                TextFormField(
                    controller: masterFieldController,
                    decoration: InputDecoration(
                      labelText: "Master / MPhil in...",
                      fillColor: Colors.brown.shade100,
                      filled: true,
                    ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: masterUniversityController,
                  decoration: InputDecoration(
                    labelText: "College / University",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: masterYearController,
                  decoration: InputDecoration(
                    labelText: "Posting Year",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                Text("2. Bachelor Level Education",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                TextFormField(
                  controller: bachelorFieldController,
                  decoration: InputDecoration(
                    labelText: "Bachelor in...",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Bachelor field is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: bachelorUniversityController,
                  decoration: InputDecoration(
                    labelText: "College / University",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Bachelor university is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: bachelorYearController,
                  decoration: InputDecoration(
                    labelText: "Posting Year",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Bachelor year is required' : null,
                ),
                SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width:
                        double.infinity, // Makes the button take the full width
                    child: ElevatedButton(
                      onPressed: () {
                        saveData();

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Save",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
