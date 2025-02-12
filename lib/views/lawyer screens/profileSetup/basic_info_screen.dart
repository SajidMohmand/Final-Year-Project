import 'package:flutter/material.dart';
import './select_domain_screen.dart';

class BasicInfoScreen extends StatefulWidget {
  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  String? selectedGender;
  String? selectedCountry;
  String? selectedCity;
  String? selectedAvailability;

  TextEditingController availabilityController = TextEditingController();

  final List<String> countries = ['Pakistan', 'USA', 'UK', 'India', 'Canada'];
  final Map<String, List<String>> cities = {
    'Pakistan': ['Lahore', 'Karachi', 'Islamabad'],
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'UK': ['London', 'Manchester', 'Birmingham'],
    'India': ['Delhi', 'Mumbai', 'Bangalore'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Information")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please provide your basic information",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),

            // Gender Selection
            Text("Gender", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
            Row(
              children: [
                Radio(
                  value: "Male",
                  activeColor: Colors.brown,
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text("Male"),
                SizedBox(width: 20),
                Radio(
                  activeColor: Colors.brown,
                  value: "Female",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text("Female"),
              ],
            ),

            SizedBox(height: 20),

            // Country Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(filled: true,
                fillColor: Colors.brown.shade100,
              ),
              hint: Text("Select Country"),
              value: selectedCountry,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedCity = null;
                });
              },
              items: countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // City Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(filled: true,
                fillColor: Colors.brown.shade100,
              ),
              hint: Text("Select City"),
              value: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              items: selectedCountry != null
                  ? cities[selectedCountry]!.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList()
                  : [],
            ),

            SizedBox(height: 20),


          SizedBox(height: 30),

            Spacer(),
            // Skip and Next Buttons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 2), // Black border
                        borderRadius: BorderRadius.circular(8), // Same border radius as the button
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SelectDomainScreen()),
                          );
                        },
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
                          MaterialPageRoute(builder: (context) => SelectDomainScreen()),
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
            ),
          ],
        ),
      ),
    );
  }
}
