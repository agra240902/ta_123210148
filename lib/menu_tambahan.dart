import 'package:flutter/material.dart';
import 'package:agra_ta/uang.dart'; // Import file uang.dart
import 'package:agra_ta/waktu.dart'; // Import file waktu.dart

class MenuTambahanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Tambahan'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman konversi mata uang (UangPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UangPage()),
                );
              },
              child: Text('Konversi Mata Uang'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman konversi waktu (WaktuPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaktuPage()),
                );
              },
              child: Text('Konversi Waktu'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman database
                Navigator.pushNamed(context, '/database');
              },
              child: Text('Database'),
            ),
          ],
        ),
      ),
    );
  }
}
