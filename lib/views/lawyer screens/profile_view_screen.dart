import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/client.dart';
import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../client screens/tabs/request/lawyer_list_screen.dart';

class ProfileViewScreen extends StatefulWidget {
  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  bool isExperienceAndEducationExpanded = false;
  bool isCasesExpanded = false;

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
                    backgroundColor: Color(0xff6D4905),
                    elevation: 0, // Removes shadow
                    actions: [
                      IconButton(
                        icon: Transform.rotate(
                          angle: -pi / 4,
                          child: Icon(
                            Icons.send,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Padding(
                                    padding: EdgeInsets.all(10),
                                    child: LawyerListScreen())),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.chat, size: 24, color: Colors.white),
                        onPressed: () {},
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
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 55.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "John Doe",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                  child: Text(
                "A Lawyer specializing in criminal law",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'OpenSans'),
              )),
              Center(
                  child: Text(
                "Available in Pakistan",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'OpenSans'),
              )),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // Wrap the first container in Expanded
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
                                "Pakistan, Lahore",
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
                      Expanded(
                        // Wrap the second container in Expanded
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
                                    color: Colors
                                        .yellow, // Yellow color for the star
                                    size: 16, // Size of the star
                                  ),
                                  SizedBox(
                                      width:
                                          5), // Space between star and rating
                                  Text(
                                    "4.7", // Example rating, replace with dynamic value if needed
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
                  child: Image.asset(
                    'assets/images/lawyer.png',
                    scale: 1.7,
                  ),
                ),
                title: Text("Education and Experience"),
                trailing: Icon(
                  isExperienceAndEducationExpanded
                      ? Icons.keyboard_arrow_down // Expanded view
                      : Icons.keyboard_arrow_right, // Collapsed view
                  size: 20,
                ),
                onTap: () {
                  setState(() {
                    isExperienceAndEducationExpanded =
                        !isExperienceAndEducationExpanded;
                  });
                },
              ),
              Divider(thickness: 1),
              if (isExperienceAndEducationExpanded) ExperienceAndEducation(),
              SizedBox(height: 5),
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
                  child: Icon(
                    Icons.gpp_good,
                    color: Colors.brown,
                    size: 28,
                  ),
                ),
                title: Text("Reviews"),
                trailing: Icon(
                  isCasesExpanded
                      ? Icons.keyboard_arrow_down // Expanded view
                      : Icons.keyboard_arrow_right, // Collapsed view
                  size: 20,
                ),
                onTap: () {
                  setState(() {
                    isCasesExpanded = !isCasesExpanded;
                  });
                },
              ),
              SizedBox(height: 5),
              Divider(
                thickness: 1,
              ),
              if (isCasesExpanded) ResolvedCasesList(),

              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class ExperienceAndEducation extends StatelessWidget {
  TextEditingController bioController = TextEditingController(
      text: "John Doe, a lawyer specializing in criminal law.");

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
    return Padding(
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
            TextField(
              controller:
                  bioController, // Set the controller with the default text
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter your bio...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.brown.shade100,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Experience",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.brown.shade100,
              ),
              child: ListTile(
                title: Text(
                  "Senior Associate at XYZ Law Firm",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location: Islamabad",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      "From: 2013 to 2017",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.brown.shade100,
              ),
              child: ListTile(
                title: Text(
                  "Senior Associate at XYZ Law Firm",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location: Islamabad",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      "From: 2013 to 2017",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),

            // Qualifications Section
            Text(
              "Qualifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/uni.png'), // Replace with your image path
                backgroundColor: Colors
                    .transparent, // Optional: set the background color if you want
              ),
              title: Text(
                "Masters in LLM",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(
                  "University of Harvard"),
              trailing: Text(
                "2002",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/uni.png'), // Replace with your image path
                backgroundColor: Colors
                    .transparent, // Optional: set the background color if you want
              ),
              title: Text(
                "Bachelors in LLB",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(
                  "University of Harvard"),
              trailing: Text(
                "1998",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResolvedCasesList extends StatefulWidget {
  @override
  _ResolvedCasesListState createState() => _ResolvedCasesListState();
}

class _ResolvedCasesListState extends State<ResolvedCasesList> {
  final List<RequestModel> requests = [
    RequestModel(
      id: '1',
      status: RequestStatus.Accepted,
      lawyer: Lawyer(
        id: '1',
        name: 'John Doe',
        phone: "03001111211",
        domain: 'Criminal Law',
        image: '',
        rating: '4.5',
        complaintNum: 0,
      ),
      client: Client(
        id: '1',
        name: 'Jane Smith',
        phone: '1234567890',
        image: '',
        complaintNum: 0,
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
    return Column(
      children: requests.map((request) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.brown.shade50,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/lawyer1.png") // Load image
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request.client.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < double.parse(request.lawyer.rating)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.yellow.shade700,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
              subtitle: Text(
                'Excellent service! Highly recommended for criminal cases.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

