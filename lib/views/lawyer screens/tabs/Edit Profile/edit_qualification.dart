import 'package:flutter/material.dart';
import 'package:fyp2/providers/lawyer_provider.dart';
import 'package:provider/provider.dart';

class EditQualification extends StatefulWidget {
  @override
  _EditQualificationState createState() => _EditQualificationState();
}

class _EditQualificationState extends State<EditQualification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController masterUniversityController = TextEditingController();
  TextEditingController masterYearController = TextEditingController();
  TextEditingController bachelorUniversityController = TextEditingController();
  TextEditingController bachelorYearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadEducationData();
  }

  void loadEducationData() async {
    final lawyerProvider = Provider.of<LawyerProvider>(context, listen: false);

    var educationList = await lawyerProvider.fetchEducation();

    // Load Master education if available

    if (educationList[0]['master']) {
      masterUniversityController.text = educationList[0]['university'] ?? '';
      masterYearController.text =educationList[0]['year'] ?? '';
    }

    bachelorUniversityController.text = educationList[1]['university'] ?? '';
    bachelorYearController.text = educationList[1]['year'] ?? '';
  }

  @override
  void dispose() {
    masterUniversityController.dispose();
    masterYearController.dispose();
    bachelorUniversityController.dispose();
    bachelorYearController.dispose();
    super.dispose();
  }

  void saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final lawyerProvider = Provider.of<LawyerProvider>(context, listen: false);

    List<Map<String, dynamic>> updatedEducation = [];

    // If Master data is filled, add it
    if (masterUniversityController.text.isNotEmpty &&
        masterYearController.text.isNotEmpty) {
      updatedEducation.add({
        "master": true,
        "university": masterUniversityController.text.trim(),
        "year": masterYearController.text.trim(),
      });
    }

    // Bachelor education (Required)
    updatedEducation.add({
      "bachelor": "LLB",
      "university": bachelorUniversityController.text.trim(),
      "year": bachelorYearController.text.trim(),
    });

    // Call updateEdu method to update Firestore
    await lawyerProvider.updateEducation(updatedEducationList: updatedEducation);

    Navigator.pop(context, true); // Close screen and refresh data
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
                Text("1. Master Level (Optional)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                    labelText: "Completion Year",
                    fillColor: Colors.brown.shade100,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                Text("2. Bachelor Level Education (Required)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),

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
                    labelText: "Completion Year",
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
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
