import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController angka1Controller = TextEditingController();
  final TextEditingController angka2Controller = TextEditingController();

  double hasil = 0;

  void hitung(String operasi) {
    double angka1 = double.parse(angka1Controller.text);
    double angka2 = double.parse(angka2Controller.text);

    setState(() {
      if (operasi == '+') {
        hasil = angka1 + angka2;
      } else if (operasi == '-') {
        hasil = angka1 - angka2;
      } else if (operasi == '×') {
        hasil = angka1 * angka2;
      } else if (operasi == '÷') {
        hasil = angka1 / angka2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: angka1Controller,
              decoration: InputDecoration(
                labelText: 'Nilai pertama',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: angka2Controller,
              decoration: InputDecoration(
                labelText: 'Nilai kedua',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    hitung('+');
                  },
                  child: Text('+'),
                ),

                ElevatedButton(
                  onPressed: () {
                    hitung('-');
                  },
                  child: Text('-'),
                ),

                ElevatedButton(
                  onPressed: () {
                    hitung('×');
                  },
                  child: Text('×'),
                ),

                ElevatedButton(
                  onPressed: () {
                    hitung('÷');
                  },
                  child: Text('÷'),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              'Hasil: $hasil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}