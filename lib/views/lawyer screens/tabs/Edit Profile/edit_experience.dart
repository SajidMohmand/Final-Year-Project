import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/profile_provider.dart';

class EditExperience extends StatefulWidget {
  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  Map<int, bool> isEditing = {};
  bool isAddingNew = false; // Track if adding new experience

  TextEditingController titleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<Map<String, String>> experience = [];
  int? editingIndex; // Track index of edited item

  @override
  void initState() {
    super.initState();
    fetchExp();
  }

  void fetchExp() async {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var fetchedExperience = await profileProvider.fetchExperience();

    setState(() {
      experience = fetchedExperience ?? [];
    });
  }

  void toggleEditMode(int index) {
    setState(() {
      if (isEditing[index] == true) {
        isEditing[index] = false;
        editingIndex = null;
      } else {
        isEditing.clear();
        isAddingNew = false; // Ensure no conflict with adding new experience
        isEditing[index] = true;
        editingIndex = index;

        titleController.text = experience[index]["title"] ?? "";
        companyController.text = experience[index]["company"] ?? "";
        locationController.text = experience[index]["location"] ?? "";
        startDateController.text = experience[index]["startDate"] ?? "";
        endDateController.text = experience[index]["endDate"] ?? "";
      }
    });
  }

  void saveExperience(int index) {
    var provider = Provider.of<ProfileProvider>(context, listen: false);

    if (_isFormEmpty()) {
      _showErrorMessage("All fields must be filled.");
      return;
    }

    Map<String, String> updatedExp = {
      "title": titleController.text,
      "company": companyController.text,
      "location": locationController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text,
    };

    provider.updateExperience(index,updatedExp);
    setState(() {
      experience[index] = updatedExp;
      isEditing[index] = false;
      editingIndex = null;
    });

    clearControllers();
  }

  void addNewExperience() {
    setState(() {
      isAddingNew = true;
      isEditing.clear();
      editingIndex = null;
      clearControllers();
    });
  }

  void saveNewExperience() {
    var provider = Provider.of<ProfileProvider>(context, listen: false);

    if (_isFormEmpty()) {
      _showErrorMessage("All fields must be filled.");
      return;
    }

    Map<String, String> newExp = {
      "title": titleController.text,
      "company": companyController.text,
      "location": locationController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text,
    };

    provider.addExperience(newExp);

    setState(() {
      experience.add(newExp);
      isAddingNew = false;
      editingIndex = null;
    });

    clearControllers();
  }

  void clearControllers() {
    titleController.clear();
    companyController.clear();
    locationController.clear();
    startDateController.clear();
    endDateController.clear();
  }

  void deleteExperience(int index) {
    var provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.deleteExperience(index);

    setState(() {
      experience.removeAt(index);
      isEditing.remove(index);
    });
  }

  void cancelEdit(int index) {
    setState(() {
      isEditing[index] = false;
      editingIndex = null;
      clearControllers();
    });
  }

  void cancelNewExperience() {
    setState(() {
      isAddingNew = false;
      clearControllers();
    });
  }

  bool _isFormEmpty() {
    return titleController.text.isEmpty ||
        companyController.text.isEmpty ||
        locationController.text.isEmpty ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Experience")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: experience.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.brown.shade100,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: isEditing[index] == true
                          ? _buildExperienceForm(index)
                          : _buildExperienceTile(index),
                    ),
                  );
                },
              ),
            ),

            // Form for adding a new experience
            if (isAddingNew) _buildExperienceForm(null),

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
                    onPressed: addNewExperience,
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
  }

  Widget _buildExperienceTile(int index) {
    return ListTile(
      title: Text(
        "${experience[index]["title"]} at ${experience[index]["company"]}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location: ${experience[index]["location"]}"),
          Text("From: ${experience[index]["startDate"]} to ${experience[index]["endDate"]}"),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.brown),
        onPressed: () => toggleEditMode(index),
      ),
    );
  }

  Widget _buildExperienceForm(int? index) {
    return Column(
      children: [
        TextFormField(controller: titleController, decoration: InputDecoration(labelText: "Job Title")),
        TextFormField(controller: companyController, decoration: InputDecoration(labelText: "Company")),
        TextFormField(controller: locationController, decoration: InputDecoration(labelText: "Location")),
        TextFormField(controller: startDateController, decoration: InputDecoration(labelText: "Start Date")),
        TextFormField(controller: endDateController, decoration: InputDecoration(labelText: "End Date")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (index != null) TextButton(
              onPressed: () => deleteExperience(index),
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: index != null ? () => cancelEdit(index) : cancelNewExperience,
                  child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: index != null ? () => saveExperience(index) : saveNewExperience,
                  child: Text("Save", style: TextStyle(color: Colors.brown)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
