import 'package:flutter/material.dart';
import 'transaction_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? newTitle;
  String? newAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      // TOmbol mengambang (FAB) untuk tambah transaksi
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, ${widget.email}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildBalanceCard(),
            const SizedBox(height: 20),
            const Text('Transaksi Terakhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildTransactionList(context), // Mengirim context ke navigasi
          ],
        ),
      ),
    );
  } 

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo Utama', style: TextStyle(fontSize: 16, color: Colors.white70)),
            SizedBox(height: 8),
            Text('Rp 5.000.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
            color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          // Transaksi baru dari AddTransactionScreen
          if (newTitle != null && newAmount != null) ...[
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.gamepad, 
            color: Colors.white,),),
            title: Text(newTitle!),
            subtitle: const Text('Hari ini'),
            trailing: Text('- Rp $newAmount', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold,),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetailScreen(
                    title: newTitle!,
                    amount: '- Rp $newAmount',
                    category: 'Game',
                    date: '5 Oktober 2026',
                  ),
                ),
              );
            },
          ),
            const Divider(height: 1),
          ],

          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.fastfood,
            color: Colors.white)),
            title: const Text('Makan Siang'),
            subtitle: const Text('Hari ini'),
            trailing: const Text('- Rp 50.000', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () {
              // Navigasi push dengan data (passing data)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionDetailScreen(
                    title: 'Makan Siang',
                    amount: '- Rp 50.000',
                    category: 'Makanan',
                    date: '13 September 2026',
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.green, child:
            Icon(Icons.attach_money, color: Colors.white)),
            title: const Text('Gaji Bulanan'),
            subtitle: const Text('1 September 2026'),
            trailing: const Text('+ Rp 5.000.000', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionDetailScreen(
                    title: 'Gaji Bulanan',
                    amount: '+ Rp 5.000.000',
                    category: 'Pemasukan',
                    date: '1 September 2026',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}