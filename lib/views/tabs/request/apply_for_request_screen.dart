import 'package:flutter/material.dart';
import 'package:fyp2/views/tabs/request/case_detail_overview_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ApplyForRequestScreen extends StatefulWidget {
  String id;
  ApplyForRequestScreen(this.id);
  @override
  _ApplyForRequestScreenState createState() => _ApplyForRequestScreenState();
}

class _ApplyForRequestScreenState extends State<ApplyForRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String? _selectedIssue;
  File? _selectedFile;

  final List<String> _cyberIssues = [
    "Cyberbullying",
    "Identity Theft",
    "Hacking / Unauthorized Access",
    "Online Fraud / Scam",
    "Privacy Violation",
    "Defamation / Harassment",
    "Others (Specify)"
  ];

  Future<void> _pickFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Case Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Case Details (optional)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey),
                SizedBox(height: 20),

                // Name field (optional, no validation)
                _buildTextField(_nameController, "Full Name", "Enter your name"),
                SizedBox(height: 20),

                // Phone field (optional, no validation)
                _buildTextField(_phoneController, "Phone Number",
                    "Enter a valid phone number",
                    keyboardType: TextInputType.phone),
                SizedBox(height: 20),

                // Dropdown for Cyber Issue (optional, no validation)
                DropdownButtonFormField<String>(
                  value: _selectedIssue,
                  decoration: InputDecoration(
                    labelText: "Type of Cyber Issue",
                    filled: true,
                    fillColor: Colors.brown.withValues(alpha: 0.1),
                  ),
                  items: _cyberIssues.map((issue) {
                    return DropdownMenuItem(value: issue, child: Text(issue));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIssue = value;
                    });
                  },
                ),
                SizedBox(height: 20),

                // Details field (optional, no validation)
                TextFormField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    labelText: "Incident Details",
                    hintText: "Describe the incident in detail...",
                    filled: true,
                    alignLabelWithHint: true,
                    fillColor: Colors.brown.withValues(alpha: 0.1),
                  ),
                  maxLines: 6,
                ),
                SizedBox(height: 20),

                // File attachment (optional)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attach File (Optional)",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            _selectedFile != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(_selectedFile!, height: 120),
                            )
                                : Container(
                              height: 120,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.brown.withValues(alpha: 0.1),
                              ),
                              child: Text(
                                "No file selected",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _pickFile,
                              icon: Icon(Icons.attach_file, color: Colors.white),
                              label: Text("Choose File"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),

                // Navigation Buttons (Back and Next)
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Back"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.brown,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          side: BorderSide(color: Colors.black, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CaseDetailOverviewScreen(widget.id,_nameController.text.toString(),
                              _phoneController.text.toString(),_selectedIssue.toString(),_detailsController.text.toString()),
                            ),
                          );
                          print("Request Submitted");
                        },
                        child: Text("Next", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          backgroundColor: Colors.brown,
                          side: BorderSide(color: Colors.black, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String validationMessage,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.brown.withValues(alpha: 0.1),
      ),
    );
  }
}
