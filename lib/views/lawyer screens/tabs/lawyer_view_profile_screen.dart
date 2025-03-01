import 'package:flutter/material.dart';
import 'package:fyp2/providers/profile_provider.dart';
import 'package:fyp2/views/lawyer%20screens/tabs/Edit%20Profile/edit_experience.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../../../providers/lawyer_provider.dart';

class LawyerViewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profileDetails = Provider.of<ProfileProvider>(context,listen: false);
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
                    elevation: 0, // Removes shadow
                    actions: [
                      IconButton(
                        icon:
                            Icon(Icons.settings, size: 24, color: Colors.white),
                        onPressed: () {
                        },
                      ),
                    ],
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

      body: Padding(
        padding: const EdgeInsets.only(
            top: 55.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "John Doe",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Color(0xffA3ADAB)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditLawyerViewProfileScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            Center(child: Text(profileDetails.bioController.text,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,fontFamily: 'OpenSans'),)),
            Center(child: Text("Available in ${profileDetails.country}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,fontFamily: 'OpenSans'),)),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(  // Wrap the first container in Expanded
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Lives in",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${profileDetails.country}, ${profileDetails.city}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(  // Wrap the second container in Expanded
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rating & Reviews",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,  // Yellow color for the star
                                  size: 16,  // Size of the star
                                ),
                                SizedBox(width: 5),  // Space between star and rating
                                Text(
                                  "4.7",  // Example rating, replace with dynamic value if needed
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(thickness: 2),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Container(
                height: 42,
                width: 42,
                color: Colors.brown.shade100,
                child: Icon(
                  Icons.gpp_good,
                  color: Colors.brown,
                  size: 28,
                ),
              ),
              title: Text("Resolved Cases"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResolvedCasesScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Container(
                height: 42,
                width: 42,
                color: Colors.brown.shade100,
                child: Image.asset(
                  'assets/images/lawyer.png',
                  scale: 1.7,
                ),
              ),
              title: Text("Education and Experience"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExperienceAndEducation(),
                  ),
                );
              },
            ),
            SizedBox(height: 5),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}


class ExperienceAndEducation extends StatelessWidget {
  final String bio = "John Doe, a lawyer specializing in criminal law.";
  final List<String> experience = [
    "Senior Associate at XYZ Law Firm (2015-2020)",
    "Legal Advisor at ABC Corporation (2020-Present)",
  ];
  final List<String> qualifications = [
    "LLB from Harvard University (2015)",
    "Juris Doctor (JD) from Yale University (2018)",
  ];

  @override
  Widget build(BuildContext context) {
    var profileDetails = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Education and Experience")),
      body: Padding(
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
                controller: profileDetails.bioController,
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


              SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditExperience()),
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.brown),
                  ),
                ],
              ),
          
              if (profileDetails.experiences.isNotEmpty)
                Column(
                  children: profileDetails.experiences.map((exp) {
                    return Container(
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
                  Icon(Icons.edit, color: Colors.brown)
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/uni.png'), // Replace with your image path
                  backgroundColor: Colors.transparent, // Optional: set the background color if you want
                ),
          
                title: Text(
                  "Masters in ${profileDetails.selectedMasterField.toString()}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text("University of ${profileDetails.selectedMasterUniversity.toString()}"),
                trailing: Text(
                  "${profileDetails.selectedMasterYear.toString()}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
          
          
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/uni.png'), // Replace with your image path
                  backgroundColor: Colors.transparent, // Optional: set the background color if you want
                ),
          
                title: Text(
                  "Bachelors in ${profileDetails.selectedBachelorField.toString()}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text("University of ${profileDetails.selectedBachelorUniversity.toString()}"),
                trailing: Text(
                  "${profileDetails.selectedBachelorYear.toString()}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
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
  final List<Request> requests = [
    Request(
      id: '1',
      status: RequestStatus.Accepted,
      lawyer: Lawyer(
        id: '1',
        name: 'John Doe',
        domain: 'Criminal Law',
        image: '',
        rating: '4.5',
      ),
      formDetails: {
        'name': 'Jane Smith',
        'phone': '1234567890',
        'issue': 'Theft Case',
        'details': 'Details about the case...',
      },
    ),
  ];

  Map<String, bool> expandedReviews = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resolved Cases")),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];

          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding:
                  EdgeInsets.only(left: 35, top: 35, right: 35, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 20,
                        top: 5,
                        bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color:
                              Colors.brown,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          'Domain: ${request.lawyer.domain}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Lawyer: ${request.lawyer.name}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Issue: ${request.formDetails['issue']}'),
                  ),
                  SizedBox(height: 5),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Divider(
                        thickness: 1,
                      )),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Review",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandedReviews[request.id] =
                                  !(expandedReviews[request.id] ?? false);
                            });
                          },
                          child: Icon(
                            expandedReviews[request.id] == true
                                ? Icons.expand_more
                                : Icons.chevron_right,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (expandedReviews[request.id] == true) ...[
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Divider(
                          thickness: 1,
                        )),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < double.parse(request.lawyer.rating)
                                      ? Icons.star
                                      : Icons
                                          .star_border,
                                  color: Colors.yellow.shade700, size: 12,
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                              'Excellent service! Highly recommended for criminal cases.',
                              style: TextStyle(fontSize: 14)),
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

class EditLawyerViewProfileScreen extends StatefulWidget {
  @override
  _EditLawyerViewProfileScreenState createState() => _EditLawyerViewProfileScreenState();
}

class _EditLawyerViewProfileScreenState extends State<EditLawyerViewProfileScreen> {
  String firstName = 'John';
  String lastName = 'Doe';
  String phoneNumber = '1234567890';
  String email = 'johndoe@example.com';
  String location = 'New York, USA';
  String address = '1234 Elm Street, NY';

  String profileImagePath = 'assets/images/profile.png';

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
      body: Padding(
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
                    onPressed: () {
                      print("Edit Personal Information");
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),
              _buildInfoRow('First Name', firstName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Last Name', lastName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Phone Number', phoneNumber),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Email', email),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),
              _buildInfoRow('Location', location),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Address', address),
              Divider(thickness: 1,),
              SizedBox(height: 7),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: "Open Sans",
            )),
        Text(value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "Open Sans",
            )),
      ],
    );
  }
}
