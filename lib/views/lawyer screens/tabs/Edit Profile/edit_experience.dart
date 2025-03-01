import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/profile_provider.dart';

class EditExperience extends StatefulWidget {
  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  Map<int, bool> isEditing = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  void toggleEditMode(int index, ProfileProvider provider) {
    setState(() {
      isEditing[index] = !(isEditing[index] ?? false);
      if (isEditing[index]!) {
        var experience = provider.experiences[index];
        titleController.text = experience["title"] ?? "";
        companyController.text = experience["company"] ?? "";
        locationController.text = experience["location"] ?? "";
        startDateController.text = experience["startDate"] ?? "";
        endDateController.text = experience["endDate"] ?? "";
      }
    });
  }

  void saveExperience(int index, ProfileProvider provider) {
    if (titleController.text.isEmpty ||
        companyController.text.isEmpty ||
        locationController.text.isEmpty ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All fields must be filled."),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop saving if validation fails
    }

    provider.experiences[index] = {
      "title": titleController.text,
      "company": companyController.text,
      "location": locationController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text,
    };
    setState(() {
      isEditing[index] = false;
    });
  }

  void addNewExperience(ProfileProvider provider) {
    provider.addExperience({
      "title": "",
      "company": "",
      "location": "",
      "startDate": "",
      "endDate": "",
    });
    setState(() {
      isEditing[provider.experiences.length - 1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Edit Experience")),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.experiences.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.brown.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: isEditing[index] == true
                              ? Column(
                              children: [
                                TextFormField(controller: titleController, decoration: InputDecoration(labelText: "Job Title")),
                                TextFormField(controller: companyController, decoration: InputDecoration(labelText: "Company")),
                                TextFormField(controller: locationController, decoration: InputDecoration(labelText: "Location")),
                                TextFormField(controller: startDateController, decoration: InputDecoration(labelText: "Start Date")),
                                TextFormField(controller: endDateController, decoration: InputDecoration(labelText: "End Date")),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () => deleteExperience(index, provider),
                                      child: Text("Delete", style: TextStyle(color: Colors.red)),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () => cancelEdit(index),
                                          child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                                        ),
                                        TextButton(
                                          onPressed: () => saveExperience(index, provider),
                                          child: Text("Save", style: TextStyle(color: Colors.brown)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],

                          )
                              : ListTile(
                            title: Text(
                              "${provider.experiences[index]["title"]} at ${provider.experiences[index]["company"]}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location: ${provider.experiences[index]["location"]}"),
                                Text("From: ${provider.experiences[index]["startDate"]} to ${provider.experiences[index]["endDate"]}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit, color: Colors.brown),
                              onPressed: () => toggleEditMode(index, provider),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => addNewExperience(provider),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Add Another Experience", style: TextStyle(fontSize: 16, color: Colors.brown)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
  void deleteExperience(int index, ProfileProvider provider) {
    provider.experiences.removeAt(index);
    provider.notifyListeners();
  }

  void cancelEdit(int index) {
    setState(() {
      isEditing[index] = false;
    });
  }

}
