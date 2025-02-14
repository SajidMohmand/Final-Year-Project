import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ClientFindLawyerScreen()));
}

class ClientFindLawyerScreen extends StatefulWidget {
  @override
  _ClientFindLawyerScreenState createState() => _ClientFindLawyerScreenState();
}

class _ClientFindLawyerScreenState extends State<ClientFindLawyerScreen> {
  final List<String> domains = [
    "Cyber Harassment",
    "Family Law",
    "Criminal Law",
    "Business Law",
    "Intellectual Property"
  ];

  final List<Map<String, String>> lawyers = [
    {
      "name": "John Doe",
      "domain": "Cyber Harassment",
      "image": "assets/images/lawyer1.png",
      "rating": "4.5"
    },
    {
      "name": "Jane Smith",
      "domain": "Cyber Harassment",
      "image": "assets/images/lawyer2.png",
      "rating": "4.7"
    },
    {
      "name": "Michael Johnson",
      "domain": "Family Law",
      "image": "assets/images/lawyer3.png",
      "rating": "4.6"
    },
    {
      "name": "Capital Johnson",
      "domain": "Family Law",
      "image": "assets/images/lawyer4.png",
      "rating": "4.0"
    },
    {
      "name": "Alice Brown",
      "domain": "Business Law",
      "image": "assets/images/lawyer5.png",
      "rating": "4.2"
    },
  ];

  void _navigateToSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchLawyerScreen(lawyers: lawyers),
      ),
    );
  }

  void _navigateToLawyerList(String domain) {
    List<Map<String, String>> domainLawyers =
    lawyers.where((lawyer) => lawyer["domain"] == domain).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LawyerListScreen(domain: domain, lawyers: domainLawyers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image(
          image: AssetImage("assets/images/splash.png"),
          width: 100,
          height: 50,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _navigateToSearchScreen,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.brown),
                    SizedBox(width: 10),
                    Text("Search lawyer by domain or name...", style: TextStyle(color: Colors.brown)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),

            Text("Browse by Domain:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: domains.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 20,
                childAspectRatio: 3.5,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => _navigateToLawyerList(domains[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    domains[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

class LawyerListScreen extends StatelessWidget {
  final String domain;
  final List<Map<String, String>> lawyers;

  LawyerListScreen({required this.domain, required this.lawyers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$domain Lawyers")),
      body: lawyers.isNotEmpty
          ? ListView.builder(
        itemCount: lawyers.length,
        itemBuilder: (context, index) {
          final lawyer = lawyers[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(lawyer["image"]!),
              ),
              title: Text(
                lawyer["name"]!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lawyer["domain"]!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text(
                        lawyer["rating"]!,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Icon(Icons.chat, color: Colors.brown),
            ),

          );
        },
      )
          : Center(child: Text("No lawyers found in this domain.")),
    );
  }
}

class SearchLawyerScreen extends StatefulWidget {
  final List<Map<String, String>> lawyers;

  SearchLawyerScreen({required this.lawyers});

  @override
  _SearchLawyerScreenState createState() => _SearchLawyerScreenState();
}

class _SearchLawyerScreenState extends State<SearchLawyerScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredLawyers = [];

  void _filterLawyers(String query) {
    setState(() {
      _filteredLawyers = widget.lawyers
          .where((lawyer) =>
      lawyer["domain"]!.toLowerCase().contains(query.toLowerCase()) ||
          lawyer["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Lawyer")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterLawyers,
              decoration: InputDecoration(
                hintText: "Search lawyer by domain or name...",
                hintStyle: TextStyle(color: Colors.brown),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                prefixIcon: Icon(Icons.search,color: Colors.brown,),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,color: Colors.brown,),
                  onPressed: () {
                    _searchController.clear();
                    _filterLawyers('');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredLawyers.isNotEmpty
                ? ListView.builder(
              itemCount: _filteredLawyers.length,
              itemBuilder: (context, index) {
                final lawyer = _filteredLawyers[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(lawyer["image"]!),
                    ),
                    title: Text(
                      lawyer["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lawyer["domain"]!,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              lawyer["rating"]!,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.chat, color: Colors.brown),
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No matches found.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
