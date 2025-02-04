import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 192,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top 4 Lawyers",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            SizedBox(
                                height: 10), // Add space between text and graph
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left side - Circle Graph
                                Container(
                                  width: 55,
                                  height: 50,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace:
                                          1, // Add small space between sections
                                      centerSpaceRadius:
                                          0, // Full circle, no center space
                                      sections: [
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.blue,
                                          radius: 27,
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.green,
                                          radius: 27,
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.red,
                                          radius: 27,
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.orange,
                                          radius: 27,
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                // Right side - Lawyer names with different colors
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLawyerName("Lawyer 1", Colors.blue),
                                    _buildLawyerName("Lawyer 2", Colors.green),
                                    _buildLawyerName("Lawyer 3", Colors.red),
                                    _buildLawyerName("Lawyer 4", Colors.orange),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 192,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top 4 Cases",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            SizedBox(
                                height: 10), // Add space between text and graph
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left side - Circle Graph with empty center
                                Container(
                                  width: 55,
                                  height: 50,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace:
                                          1, // Small space between sections
                                      centerSpaceRadius:
                                          14, // Set the empty center radius
                                      sections: [
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.blue,
                                          radius: 15, // Outer circle radius
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.green,
                                          radius: 15, // Outer circle radius
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.red,
                                          radius: 15, // Outer circle radius
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                        PieChartSectionData(
                                          value: 25,
                                          color: Colors.orange,
                                          radius: 15, // Outer circle radius
                                          showTitle:
                                              false, // Hide the title inside the slice
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                // Right side - Lawyer names with different colors
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLawyerName("Case 1", Colors.blue),
                                    _buildLawyerName("Case 2", Colors.green),
                                    _buildLawyerName("Case 3", Colors.red),
                                    _buildLawyerName("Case 4", Colors.orange),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(children: [
                  Container(
                    height: 27,
                    width: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.brown
                    ),
                    child: Icon(
                      Icons.redeem_sharp,color: Colors.white,size: 15,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "Recent Lawyer Request",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                  ),
                ],),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 50, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      "Email",textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      "Cases",textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    _buildRow(
                        'Anwar Bahi', 'anwarbahi@gmail.com', 'Cyber Bullying'),
                    _buildRow(
                        'Capital', 'john.doe@example.com', 'Cyber Bullying'),
                    _buildRow('Ali', 'ali@example.com', 'Data Theft'),
                    _buildRow(
                        'Anwar Bahi', 'anwarbahi@gmail.com', 'Cyber Bullying'),
                    _buildRow(
                        'Capital', 'john.doe@example.com', 'Cyber Bullying'),
                    _buildRow('Ali', 'ali@example.com', 'Data Theft'),
                    _buildRow(
                        'Anwar Bahi', 'anwarbahi@gmail.com', 'Cyber Bullying'),
                    _buildRow(
                        'Capital', 'john.doe@example.com', 'Cyber Bullying'),
                  ],
                ),
              ),
              
              ListTile(
                title: Text("Reported Cases",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),),
                trailing: Container(
                  height: 40,
                  width: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                                color: Color(0xfff5cba5),
                            ),
                          ),
                          Text("Total cases",style: TextStyle(fontWeight: FontWeight.w600),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xff6D4905),
                            ),
                          ),
                          Text("Reported cases",style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Cyber Buyling",style: TextStyle(fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 17,
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey[300], // Background bar
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 17,
                              width: (40 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Color(0xff6D4905),
                              ),
                            ),
                            Container(
                              height: 17,
                              width: (60 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xfff5cba5),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Cyber Buyling",style: TextStyle(fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 17,
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey[300], // Background bar
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 17,
                              width: (30 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Color(0xff6D4905),
                              ),
                            ),
                            Container(
                              height: 17,
                              width: (70 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xfff5cba5),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Cyber Buyling",style: TextStyle(fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 17,
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey[300], // Background bar
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 17,
                              width: (80 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Color(0xff6D4905),
                              ),
                            ),
                            Container(
                              height: 17,
                              width: (20 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xfff5cba5),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Cyber Buyling",style: TextStyle(fontWeight: FontWeight.w500),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 17,
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey[300], // Background bar
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 17,
                              width: (10 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Color(0xff6D4905),
                              ),
                            ),
                            Container(
                              height: 17,
                              width: (90 / 100) * MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xfff5cba5),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String name, String email, String cases) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 100, // Fixed width for Name column
            child: Text(name, textAlign: TextAlign.left,style: TextStyle(fontSize: 12),),
          ),
          Expanded(
            child: Text(email, textAlign: TextAlign.left,style: TextStyle(fontSize: 12),),
          ),
          SizedBox(
            width: 120, // Adjust width to align 'Cases' properly
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(cases, textAlign: TextAlign.left,style: TextStyle(fontSize: 12),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLawyerName(String name, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16, // Width of the color box
          height: 16, // Height of the color box
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16),),
        ),
        SizedBox(width: 8), // Space between color box and name
        Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
  final List<FlSpot> spots = [
    FlSpot(0, 2),
    FlSpot(1, 4),
    FlSpot(2, 3),
    FlSpot(3, double.nan), // Invalid value
    FlSpot(4, double.infinity), // Invalid value
  ].where((spot) => spot.y.isFinite).toList(); // Filter out NaN and Infinity

}
