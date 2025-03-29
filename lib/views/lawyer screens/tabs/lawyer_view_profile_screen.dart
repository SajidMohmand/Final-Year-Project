import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:fyp2/views/lawyer%20screens/tabs/Edit%20Profile/edit_experience.dart';
import 'package:fyp2/views/lawyer%20screens/tabs/Edit%20Profile/edit_qualification.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/client.dart';
import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../../../providers/lawyer_provider.dart';


class LawyerViewProfileScreen extends StatefulWidget {
  @override
  State<LawyerViewProfileScreen> createState() => _LawyerViewProfileScreenState();
}

class _LawyerViewProfileScreenState extends State<LawyerViewProfileScreen> {
  Future<Lawyer?> fetchLawyer() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser?.uid ?? '';
    return await Provider.of<LawyerProvider>(context, listen: false).getLawyerById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(154),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xff6D4905),
                    elevation: 0,
                    centerTitle: true,
                  ),
                ),

                Positioned(
                  bottom: -60,
                  left: constraints.maxWidth / 2 - 60,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: FutureBuilder<Lawyer?>(
        future: fetchLawyer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("Lawyer not found"));
          }

          Lawyer lawyer = snapshot.data!;

          return SingleChildScrollView(
            child:Padding(
              padding: EdgeInsets.only(top: 55),
              child: Column(
                children: [

                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${lawyer.firstName ?? ''} ${lawyer.lastName ?? ''}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Color(0xffA3ADAB)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditLawyerProfileScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),


                  Text(
                    lawyer.profile?.bio ?? "No bio available",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Available in ${lawyer.profile?.country ?? 'Unknown'}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Lives in",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${lawyer.profile?.country ?? 'Unknown'}, ${lawyer.profile?.city ?? 'Unknown'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Rating & Reviews",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                    lawyer.rating.toString() ?? 'No Rating',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    leading: Container(
                      height: 42,
                      width: 42,
                      color: Colors.brown.shade100,
                      child: Icon(Icons.gpp_good, color: Colors.brown, size: 28),
                    ),
                    title: Text("Resolved Cases"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResolvedCasesScreen()),
                      );
                    },
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    leading: Container(
                      height: 42,
                      width: 42,
                      color: Colors.brown.shade100,
                      child: Image.asset('assets/images/lawyer.png', scale: 1.7),
                    ),
                    title: Text("Education and Experience"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExperienceAndEducation()),
                      );
                    },
                  ),
                  Divider(thickness: 1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



class ExperienceAndEducation extends StatefulWidget {
  @override
  State<ExperienceAndEducation> createState() => _ExperienceAndEducationState();
}

class _ExperienceAndEducationState extends State<ExperienceAndEducation> {
  String? bio;

  List<Map<String, dynamic>>? experience;

  List<Map<String, dynamic>>? qualifications;
  bool needsUpdate = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (needsUpdate) {
      setState(() {
        needsUpdate = false; // Reset after updating UI
      });
    }
  }
  Lawyer? lawyer;

  @override
  void initState() {
    super.initState();
    experience = []; // Initialize as empty
    qualifications = []; // Initialize as empty
    fetchData(); // Call async function
  }

  Future<void> fetchData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String id = auth.currentUser!.uid;

      final provider = Provider.of<LawyerProvider>(context, listen: false);
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      // Fetch data asynchronously
      lawyer = await provider.getLawyerById(id);
      experience = await profile.fetchExperience();
      qualifications = await provider.fetchEducation();


      setState(() {
        profile.bioController.text = lawyer?.profile!.bio ?? ''; // Set previous bio
      });
      bio = lawyer?.profile?.bio ?? ''; // Handle null safety


    } catch (error) {
      print("Error fetching data: $error");
    }
  }




  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ProfileProvider>(context,listen: false);
    var lawyerProvider = Provider.of<LawyerProvider>(context,listen: false);
    fetchData();
    return Scaffold(
      appBar: AppBar(title: Text("Education and Experience")),
      body: experience == null || qualifications == null ? Center(child: CircularProgressIndicator()) :Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bio Section
              Text(
                "About",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: profile.bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Update your bio...",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.brown.shade100,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onSaved: (newBio) async {
                  if (newBio!.trim().isNotEmpty) {
                    await profile.updateBio(newBio.trim());
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bio is required';
                  }
                  return null;
                },
              ),

              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: () async {
                  if (profile.bioController.text.trim().isNotEmpty) {
                    await profile.updateBio(profile.bioController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text("Bio updated successfully!")),
                        duration: Duration(seconds: 2), // Show for 2 seconds
                      ),
                    );

                  }
                },
                  child: Text("Save",style: TextStyle(color: Colors.brown,fontSize: 15)),),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditExperience()),
                      );

                      if (result == true) {
                        setState(() {
                          needsUpdate = true; // Set flag to update UI
                        });
                      }
                    },

                      icon: Icon(Icons.edit, color: Colors.brown),
                  ),
                ],
              ),

              if (experience!.isNotEmpty)
                Column(
                  children: experience!.map((exp) {
                    return Container(
                      margin: EdgeInsets.only(top: 3,bottom: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.brown.shade100,
                      ),
                      child: ListTile(
                        title: Text(
                          "${exp["title"]!} at ${exp["company"]!}",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location: ${exp["location"]!}",
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              "From: ${exp["startDate"]!} to ${exp["endDate"]!}",
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),

                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )

              else
                Text(
                  "No experience added yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              SizedBox(height: 40),

              // Qualifications Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Qualifications",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditQualification()),
                        );
                      },

                      child: Icon(Icons.edit, color: Colors.brown))
                ],
              ),
              SizedBox(height: 10),

              if (qualifications != null && qualifications!.isNotEmpty)
                Column(
                  children: [
                    if (qualifications!.isNotEmpty && qualifications![0]['master'] == true)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/uni.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          "Masters in LLM",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          "University of ${qualifications![0]["university"] ?? "Not specified"}",
                        ),
                        trailing: Text(
                          qualifications![0]["year"] ?? "Year not specified",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),

                    if (qualifications!.length > 1) // Check if Bachelor exists
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/uni.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          "Bachelors in LLB",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          "University of ${qualifications![1]["university"] ?? "Not specified"}",
                        ),
                        trailing: Text(
                          qualifications![1]["year"] ?? "Year not specified",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                )
              else
                Text(
                  "No qualifications added yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

            ],
          ),
        ),
      ),
    );
  }
}




class ResolvedCasesScreen extends StatefulWidget {
  @override
  _ResolvedCasesScreenState createState() => _ResolvedCasesScreenState();
}

class _ResolvedCasesScreenState extends State<ResolvedCasesScreen> {
  List<Map<String, String>>? resolveCases;
  Map<String, bool> expandedReviews = {}; // Tracks expanded state per case

  @override
  void initState() {
    super.initState();
    fetchResolvedCases();
  }

  void fetchResolvedCases() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;

    if (id != null) {
      List<Map<String, String>>? data =
      await Provider.of<LawyerProvider>(context, listen: false).getResolvedCases();
      setState(() {
        resolveCases = data;
        expandedReviews = {for (var caseData in data ?? []) caseData["caseId"]!: false};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resolved Cases")),
      body: resolveCases == null
          ? Center(child: Text("No resolved cases available")) // Handle loading state
          : ListView.builder(
        itemCount: resolveCases!.length,
        itemBuilder: (context, index) {
          final caseData = resolveCases![index];
          String caseId = caseData["caseId"] ?? "unknown"; // Use unique identifier

          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.brown, width: 2.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Domain: ${caseData["domain"]}',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Client: ${caseData["clientName"] ?? "N/A"}',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Issue: ${caseData["issue"]}'),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Divider(thickness: 1),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Review", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandedReviews[caseId] = !(expandedReviews[caseId] ?? false);
                            });
                          },
                          child: Icon(
                            expandedReviews[caseId] == true ? Icons.expand_more : Icons.chevron_right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (expandedReviews[caseId] == true) ...[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Divider(thickness: 1),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < int.parse(caseData["rating"] ?? "0")
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow.shade700,
                                  size: 12,
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            caseData["review"] ?? "No review available",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditLawyerProfileScreen extends StatefulWidget {
  EditLawyerProfileScreen();
  @override
  _EditLawyerProfileScreenState createState() => _EditLawyerProfileScreenState();
}

class _EditLawyerProfileScreenState extends State<EditLawyerProfileScreen> {

  String profileImagePath = 'assets/images/profile.png';

  Lawyer? lawyer;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lawyer = null;
    fetchClient();
  }
  @override
  void initState() {
    super.initState();
    fetchClient();
  }

  void fetchClient() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;

    if (id != null) {
     Lawyer? data = await Provider.of<LawyerProvider>(context, listen: false).getLawyerById(id);
      setState(() {
        lawyer = data;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: lawyer == null? Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage(profileImagePath),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: TextButton(
                  onPressed: _pickImage,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    "Change Image",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Info',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans'),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit,
                        color: Color(
                            0xff6F7977)),
                    onPressed: () async{
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateLawyerProfileScreen()));
                      print("Edit Personal Information");
                      setState(() {
                        fetchClient();

                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),
              _buildInfoRow('First Name', lawyer!.firstName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Last Name', lawyer!.lastName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Phone Number', lawyer!.phone),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Email', lawyer!.email),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Address', "${lawyer!.profile!.city.toString()} ${lawyer!.profile!.country}"),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: "Open Sans",
            )),
        Text(value ?? 'N/A', // Default value for null
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "Open Sans",
            )),
      ],
    );
  }

}
class UpdateLawyerProfileScreen extends StatefulWidget {
  @override
  _UpdateLawyerProfileScreenState createState() =>
      _UpdateLawyerProfileScreenState();
}

class _UpdateLawyerProfileScreenState extends State<UpdateLawyerProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String profileImagePath = 'assets/images/profile.png';
  String userId = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchClient();
  }

  Future<void> fetchClient() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        userId = user.uid;

        Lawyer? lawyer = await Provider.of<LawyerProvider>(context, listen: false).getLawyerById(userId);

        if (lawyer != null) {
          setState(() {
            firstNameController.text = lawyer.firstName;
            lastNameController.text = lawyer.lastName;
            phoneController.text = lawyer.phone;
            emailController.text = lawyer.email;
            cityController.text = lawyer.profile?.city ?? '';
            countryController.text = lawyer.profile?.country ?? '';
          });
        } else {
          print("Lawyer not found");
        }
      }
    } catch (error) {
      print("Error fetching client: $error");
    }
  }

  Future<void> updateClientProfile() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance.collection('lawyers').doc(userId).update({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'profile.city': cityController.text,
      'profile.country': countryController.text,
    });

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text("Profile Updated Successfully!",style: TextStyle(color: Colors.white),)),
      backgroundColor: Colors.brown,
    ));
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(profileImagePath),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: _pickImage,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  child: Text("Change Image", style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("First Name", firstNameController),
              _buildTextField("Last Name", lastNameController),
              _buildTextField("Phone Number", phoneController),
              _buildTextField("Email", emailController),
              _buildTextField("City", cityController),
              _buildTextField("Country", countryController),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity, // Full width
                child: TextButton(
                  onPressed: updateClientProfile,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Reduced border radius
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }




  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.brown.shade100,
            filled: true
        ),
      ),
    );
  }

}
