import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agra_ta/login.dart';
import 'package:agra_ta/home_page.dart';
import 'package:agra_ta/saran.dart';

class Team {
  final String name;
  final String logo;
  final String venue;

  Team({required this.name, required this.logo, required this.venue});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['team_name'],
      logo: json['team_logo'],
      venue: json['team_venue'],
    );
  }
}

class AplikasiPage extends StatefulWidget {
  @override
  _AplikasiPageState createState() => _AplikasiPageState();
}

class _AplikasiPageState extends State<AplikasiPage> {
  int _currentIndex = 2;
  TextEditingController _searchController = TextEditingController();
  List<Team> _teams = []; // List yang akan menyimpan hasil pencarian

  Future<List<Team>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://agra240902.github.io/liga1_api/liga1.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Team> teams = data.map((json) => Team.fromJson(json)).toList();
      return teams;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((teams) {
      setState(() {
        _teams = teams;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Page'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              searchQuery(_searchController.text);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari tim...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    clearSearchResults();
                  },
                ),
              ),
              onSubmitted: (value) {
                searchQuery(value);
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: _teams.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _teams.length,
                itemBuilder: (context, index) {
                  var item = _teams[index];
                  return Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Image.network(item.logo),
                      title: Text(item.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text('Venue: ${item.venue}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SaranPage()),
            );
          } else if (index == 2) {
            // Handle aplikasi menu navigation
          } else if (index == 3) {
            _handleLogout();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Saran',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.apps),
            label: 'Aplikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void searchQuery(String query) {
    List<Team> searchResults = _teams
        .where((team) => team.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _teams = searchResults;
    });
  }

  void clearSearchResults() {
    _searchController.clear();
    fetchData().then((teams) {
      setState(() {
        _teams = teams;
      });
    });
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Aplikasi TA',
    home: AplikasiPage(),
  ));
}
