import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agra_ta/login.dart';
import 'package:agra_ta/home_page.dart';

class SaranPage extends StatefulWidget {
  @override
  _SaranPageState createState() => _SaranPageState();
}

class _SaranPageState extends State<SaranPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran dan Kesan'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saran dan Kesan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Saran:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pak Bagus mohon untuk refreshing di tengah pembelajaran di adakan lagi,seperti mendengarkan musik/nonton kartun.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Kesan:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Selama mengikuti perkuliahan Pak Bagus ,saya mendapatkan banyak ilmu dan wawasan.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
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
            // Do nothing as it's already on SaranPage
          } else if (index == 2) {
            // Handle aplikasi menu navigation
          } else if (index == 3) {
            // Handle logout
            _handleLogout();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.lightbulb),
            label: 'Saran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Aplikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout), // Icon untuk logout
            label: 'Logout', // Label untuk logout
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
}
