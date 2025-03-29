import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/providers/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/client.dart';
import '../../../models/lawyer.dart';
import '../../../models/request.dart';
import '../../../providers/lawyer_provider.dart';
import '../../lawyer screens/profile_view_screen.dart';

class ClientProfileScreen extends StatefulWidget {

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {

  Client? clientData;

  @override
  void initState() {
    super.initState();

    fetchClient();
  }



  void fetchClient() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser!.uid;

    try {
      Client? data = await Provider.of<ClientProvider>(context,listen: false).getClientById(id);

      if (data != null) {
        setState(() {
          clientData = data;
        });
      } else {
        print("No client data found for this ID.");
      }
    } catch (e) {
      print("Error fetching client: $e");
    }
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
                    elevation: 0, // Removes shadow

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
                          "assets/images/profile.png"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      body: clientData == null ? Center(child: CircularProgressIndicator()): Padding(
        padding: const EdgeInsets.only(
            top: 65.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "${clientData!.firstName} ${clientData!.lastName}"
                    ,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Color(0xffA3ADAB)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditClientProfileScreen(),
                      ),
                    );
                  },
                )
              ],
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

class LawyerSelectionScreen extends StatefulWidget {
  @override
  State<LawyerSelectionScreen> createState() => _LawyerSelectionScreenState();
}

class _LawyerSelectionScreenState extends State<LawyerSelectionScreen> {

  List<Map<String, String>> lawyers = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ClientProvider>(context,listen: false).fetchConnectedLawyers().then((lawyers) {
      setState(() {
        lawyers = lawyers;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

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
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileViewScreen(),
                                ),
                              );
                            },

                            child: CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(
                                lawyer["image"]!,
                              ),
                            ),
                          ),
                          title: Text(
                            lawyer["name"]!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lawyer["domain"]!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    lawyer["rating"]!,
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
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No connected lawyers found.",
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
  List<Map<String, String>>? resolveCases;
  Map<String, bool> expandedReviews = {}; // ✅ Tracks expanded state per case

  @override
  void initState() {
    super.initState();
    fetchClient();
  }

  void fetchClient() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;

    if (id != null) {
      List<Map<String, String>>? data =
      await Provider.of<ClientProvider>(context, listen: false).getResolvedCases();
      setState(() {
        resolveCases = data;
        expandedReviews = {for (var caseData in data ?? []) caseData["caseId"]!: false}; // ✅ Initialize expanded states
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resolved Cases")),
      body: resolveCases == null
          ? Center(child: Text("!Not have resolve cases")) // ✅ Handle loading state
          : ListView.builder(
        itemCount: resolveCases!.length,
        itemBuilder: (context, index) {
          final caseData = resolveCases![index];
          String caseId = caseData["caseId"] ?? "unknown"; // ✅ Use unique identifier

          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.only(left: 35, top: 35, right: 35, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
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
                          'Lawyer: ${caseData['lawyername']}',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Issue: ${caseData['issue']}'),
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
                              expandedReviews[caseId] = !(expandedReviews[caseId] ?? false); // ✅ Toggle expanded state
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
                        children: [
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < int.parse(caseData["rating"] ?? "0") ? Icons.star : Icons.star_border,
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




class EditClientProfileScreen extends StatefulWidget {
  EditClientProfileScreen();
  @override
  _EditClientProfileScreenState createState() => _EditClientProfileScreenState();
}

class _EditClientProfileScreenState extends State<EditClientProfileScreen> {

  String profileImagePath = 'assets/images/profile.png';

  Client? clientData;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      Client? data = await Provider.of<ClientProvider>(context, listen: false).getClientById(id);
      setState(() {
        clientData = data;
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
      body: clientData == null ? Center(child: CircularProgressIndicator(),):Padding(
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
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateClientProfileScreen()));
                      setState(() {
                        fetchClient();

                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),
              _buildInfoRow('First Name', clientData!.firstName),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Last Name', clientData!.lastName),

              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Email', clientData!.email),
              SizedBox(height: 7),
              Divider(thickness: 1,),
              SizedBox(height: 7),

              _buildInfoRow('Address', clientData!.profile!.address),
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



class UpdateClientProfileScreen extends StatefulWidget {
  @override
  _UpdateClientProfileScreenState createState() =>
      _UpdateClientProfileScreenState();
}

class _UpdateClientProfileScreenState extends State<UpdateClientProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String profileImagePath = 'assets/images/profile.png';
  String userId = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchClient();
  }

  Future<void> fetchClient() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      userId = user.uid;

      DocumentSnapshot clientSnapshot =
      await FirebaseFirestore.instance.collection('clients').doc(userId).get();

      if (clientSnapshot.exists) {
        Map<String, dynamic> clientData = clientSnapshot.data() as Map<String, dynamic>;

        setState(() {
          firstNameController.text = clientData['firstName'] ?? '';
          lastNameController.text = clientData['lastName'] ?? '';
          emailController.text = clientData['email'] ?? '';
          addressController.text = clientData['profile']?['address'] ?? '';
        });
      }
    }
  }

  Future<void> updateClientProfile() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance.collection('clients').doc(userId).update({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'profile.address': addressController.text,
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
              _buildTextField("Email", emailController),
              _buildTextField("Address", addressController),
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
