import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agra_ta/login.dart';
import 'package:agra_ta/saran.dart';
import 'package:agra_ta/aplikasi.dart';
import 'package:agra_ta/uang.dart'; // Import file uang.dart
import 'package:agra_ta/waktu.dart'; // Import file waktu.dart
import 'package:agra_ta/menu_tambahan.dart'; // Import file menu_tambahan.dart

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false, // Disable the back button
      ),
      body: Center(
        // Menggunakan Center untuk memastikan semua elemen berada di tengah
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage(
                    'assets/gambar.jpeg', // Ganti dengan path gambar profil Anda
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'AGRA NIBRASUL AF',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Mahasiswa',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Teknologi Pemograman Mobile IFA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 32.0), // Spasi antara deskripsi dan tombol
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman MenuTambahanPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuTambahanPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Ubah warna latar belakang menjadi hitam
                  ),
                  child: Text(
                    'Tambahan',
                    style: TextStyle(
                      color: Colors.white, // Ubah warna teks menjadi putih
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation based on index
          if (index == 0) {
            // Handle profil menu navigation
          } else if (index == 1) {
            // Handle saran menu navigation
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SaranPage()),
            );
          } else if (index == 2) {
            // Handle aplikasi menu navigation
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AplikasiPage()),
            );
          } else if (index == 3) {
            // Handle logout
            _handleLogout();
          }
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: CircleAvatar(
              radius: 12.0, // Sesuaikan ukuran radius sesuai kebutuhan
              backgroundImage: AssetImage(
                'assets/gambar.jpeg', // Ganti dengan path gambar profil Anda
              ),
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
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

void main() {
  runApp(MaterialApp(
    title: 'Aplikasi TA',
    home: HomePage(),
    routes: {
      '/konversi_mata_uang': (context) => UangPage(),
      '/konversi_waktu': (context) => WaktuPage(),
      '/menu_tambahan': (context) => MenuTambahanPage(),
    },
  ));
}
