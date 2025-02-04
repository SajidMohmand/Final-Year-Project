import 'package:flutter/material.dart';
import 'package:fyp2/views/drawer/dashboard_screen.dart';
import 'package:fyp2/views/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../providers/register_provider.dart';
import '../views/drawer/complaint_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, // Allow avatar to overflow the container
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27, // Increased height
                decoration: BoxDecoration(
                  color: Colors.brown, // Background color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: 155, // Keep same position
                left: 110,
                child: Container(
                  width: 83,
                  height: 83,
                  child: CircleAvatar(
                    radius: 40, // Adjust size
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 38, // Slightly smaller for a border effect
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 240, // Keep same position
                left: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sajid Khan",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 80), // Increased space below to avoid overlap
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=> DashboardScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text("Complaint"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=> ComplaintScreen()));


            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Provider.of<RegisterProvider>(context, listen: false).clearRole();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Padding(
                        padding: EdgeInsets.all(10),
                        child: LoginScreen())),
              );
            },
          ),
        ],
      ),
    );
  }
}
