import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ApplyForRequestScreen extends StatefulWidget {
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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Align(
                  alignment: Alignment.center,
                  child: Text("Case Details (optional)",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.length != 10 ? "Enter a valid phone number" : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedIssue,
                decoration: InputDecoration(labelText: "Type of Cyber Issue"),
                items: _cyberIssues.map((issue) {
                  return DropdownMenuItem(value: issue, child: Text(issue));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIssue = value;
                  });
                },
                validator: (value) => value == null ? "Select an issue" : null,
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: "Incident Details"),
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? "Provide incident details" : null,
              ),
              SizedBox(height: 10),
              _selectedFile != null
                  ? Image.file(_selectedFile!, height: 100)
                  : Text("No file selected"),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text("Attach File (Optional)"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Back"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Request Submitted");
                      }
                    },
                    child: Text("Next"),
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
