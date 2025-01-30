import 'package:flutter/material.dart';
import 'package:fyp2/views/tabs/request_screen.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/lawyer.dart';
import '../../models/request.dart';
import '../../providers/lawyer_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(154), // Set AppBar height
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none, // Ensures the image is not clipped
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
                          // Handle settings action
                        },
                      ),
                    ],
                    centerTitle: true,
                  ),
                ),

                // Profile Image Positioned in the AppBar
                Positioned(
                  bottom: -60, // Slightly overlaps the body
                  left: constraints.maxWidth / 2 - 60, // Centers image
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
                          'assets/images/profile.png'), // Change to your image asset
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
            top: 65.0), // Adjusted for profile image overlap
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Name with Edit Icon
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
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                  },
                )
              ],
            ),

            // Horizontal Divider
            Divider(thickness: 2),

            SizedBox(
              height: 20,
            ),
            // Clickable Resolved Cases
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
            // Clickable Lawyer List
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
              title: Text("Lawyer List"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyerSelectionScreen(),
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

class LawyerSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the list of filtered lawyers from the provider
    final lawyerProvider = Provider.of<LawyerProvider>(context);
    final lawyers = lawyerProvider.filteredLawyers;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lawyers List"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: lawyers.isNotEmpty
                ? ListView.builder(
                    itemCount: lawyers.length,
                    itemBuilder: (context, index) {
                      final lawyer = lawyers[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              lawyer.image,
                            ),
                          ),
                          title: Text(
                            lawyer.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lawyer.domain,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    lawyer.rating,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.message,
                                color: Colors.brown, size: 24),
                            onPressed: () {
                              // Handle message action
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No matches found.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
          ),
        ],
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

  // Track expanded review sections
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
                        bottom: 5), // Adjusted padding for consistency
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color:
                              Colors.brown, // Set the color of the left border
                          width: 2.0, // Set the width of the left border
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Ensures the text is aligned to the left
                      children: [
                        Text(
                          'Domain: ${request.lawyer.domain}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16, // Same font size for consistency
                          ),
                        ),
                        SizedBox(height: 5), // Adds spacing between texts
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
                  SizedBox(height: 10), // Adjust spacing between sections
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
                  // Row with Review Text & Icon
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

                  // Expandable Review Section
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
                                          .star_border, // Filled star if index < rating, else empty star
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

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String firstName = 'John';
  String lastName = 'Doe';
  String phoneNumber = '1234567890';
  String email = 'johndoe@example.com';
  String location = 'New York, USA';
  String address = '1234 Elm Street, NY';

  // Default profile image
  String profileImagePath = 'assets/images/profile.png';

  // Function to pick an image from the gallery
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
              // Circular avatar with change image button
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage(profileImagePath), // Use picked image
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: TextButton(
                  onPressed: _pickImage, // Handle image change action
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown, // Set the background color
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20), // Padding for the button
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(7), // Round the corners
                    ), // Text color
                  ),
                  child: Text(
                    "Change Image",
                    style: TextStyle(fontSize: 16), // Text size
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
                            0xff6F7977)), // Edit icon for Personal Information
                    onPressed: () {
                      print("Edit Personal Information");
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),
              // First Name
              _buildInfoRow('First Name', firstName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              // Last Name
              _buildInfoRow('Last Name', lastName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              // Phone Number
              _buildInfoRow('Phone Number', phoneNumber),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              // Email
              _buildInfoRow('Email', email),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),
              // Location
              _buildInfoRow('Location', location),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              // Address
              _buildInfoRow('Address', address),
              Divider(thickness: 1,),
              SizedBox(height: 7),

            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a row with information
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
