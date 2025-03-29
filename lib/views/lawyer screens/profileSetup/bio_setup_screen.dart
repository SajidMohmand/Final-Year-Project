import 'package:flutter/material.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'add_experience_screen.dart';

class BioSetupScreen extends StatefulWidget {
  @override
  _BioSetupScreenState createState() => _BioSetupScreenState();
}

class _BioSetupScreenState extends State<BioSetupScreen> {
  late TextEditingController bioController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedMasterUniversity;
  String? selectedMasterYear;
  String? selectedBachelorUniversity;
  String? selectedBachelorYear;
  bool isMasterSelected = false;
  bool isBachelorSelected = false;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController();
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  void saveData() {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.updateBio(bioController.text);

    List<Map<String, dynamic>> list = [];

      list.add({
        "master": isMasterSelected,
        "university": selectedMasterUniversity ?? "Not specified",
        "year": selectedMasterYear ?? "Not specified",
      });

      list.add({
        "bachelor": isBachelorSelected,
        "university": selectedBachelorUniversity ?? "Not specified",
        "year": selectedBachelorYear ?? "Not specified",
      });

    profileProvider.addEducation(list);
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
                    filled: true,
                    fillColor: Colors.brown.shade100,
                  ),
                  validator: (value) => value!.trim().isEmpty ? 'Bio is required' : null,
                ),
                SizedBox(height: 30),

                _buildEducationSection(
                  "Master",
                  isMasterSelected,
                      (value) => setState(() => isMasterSelected = !isMasterSelected),
                      (university) => selectedMasterUniversity = university,
                      (year) => selectedMasterYear = year,
                ),

                SizedBox(height: 30),

                _buildEducationSection(
                  "Bachelor",
                  isBachelorSelected,
                      (value) => setState(() => isBachelorSelected = !isBachelorSelected),
                      (university) => selectedBachelorUniversity = university,
                      (year) => selectedBachelorYear = year,
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
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
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
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

  Widget _buildEducationSection(
      String title,
      bool isSelected,
      Function(bool) onToggle,
      Function(String?) onUniversityChange,
      Function(String?) onYearChange,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onToggle(!isSelected),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.brown.shade300 : Colors.brown.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$title Level Education", style: TextStyle(fontSize: 16)),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (isSelected) ...[
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.brown.shade100,
              hintText: "College / University",
            ),
            items: universities.map((uni) => DropdownMenuItem(value: uni, child: Text(uni))).toList(),
            onChanged: onUniversityChange,
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.brown.shade100,
              hintText: "Posting Year",
            ),
            items: years.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
            onChanged: onYearChange,
          ),
        ],
      ],
    );
  }
}
