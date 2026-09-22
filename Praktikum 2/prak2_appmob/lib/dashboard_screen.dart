import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Widget Utama

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(), // Halaman awal aplikasi
    );
  }
}

// 2. Halaman Utama (Scaffold)

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 1: Widgets'),
        backgroundColor: Colors.blue,
      ),
      // Padding untuk memberikan jarak dari tepi layar
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingWidget(),       // Memanggil StatelessWidget
            SizedBox(height: 20),   // Jarak vertikal
            BalanceCardWidget(),    // Memanggil StatefulWidget
          ],
        ),
      ),
    );
  }
}

// 3. Stateless Widget (Sapaan Pengguna)

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Ikon Profil
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 30, color: Colors.white),
        ),
        SizedBox(width: 12),
        // Teks Sapaan
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Budi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Selamat datang kembali!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 4. Stateful Widget (Kartu Saldo dengan Toggle)

class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<BalanceCardWidget> {
  // variabel state: menyimpan status apakah saldo terlihat atau disensor
  bool _isBalanceVisible = true;

  // fungsi untuk mengubah state
  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
     }); // membalik nilai boolean (true <-> false)
    }

    @override
    Widget build(BuildContext context) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris atas kartu: Teks "Saldo Utama" & Tombol Ikon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saldo Utama',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  // Tombol mata
                  IconButton(
                    icon: Icon(
                      // Logika if-else singkat (ternary operator)
                      _isBalanceVisible ? Icons.visibility: Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: _toggleVisibility, // Memanggil fungsi ubah state
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Teks Nominal Saldo
              Text(
                // Logika if-else untuk menampilkan saldo atau sensor
                _isBalanceVisible ? 'Rp 5.000.000' : 'Rp *********',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'No. Rekening: 1234-5678',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }