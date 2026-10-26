import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/transaction_model.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;
  final String userName;

  const DashboardScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _balance = 0;
  List<TransactionModel> _transactions = [];
  bool _isLoading = true;
  bool _hideBalance = false;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final balance = await DatabaseHelper.instance.getBalance(
        widget.userId,
      );

      final transactions =
          await DatabaseHelper.instance.getTransactions(
        widget.userId,
      );

      if (!mounted) return;

      setState(() {
        _balance = balance;
        _transactions = transactions.take(5).toList();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  String _formatRupiah(double amount) {
    final value = amount.abs().toStringAsFixed(0);

    final formatted = value.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }

  Future<void> _openAddTransaction({String? type}) async {
    final result = await Navigator.pushNamed(
      context,
      '/add',
      arguments: {
        'userId': widget.userId,
        'type': type,
      },
    );

    if (result == true) {
      await _loadDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFE53935);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Beranda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _loadDashboard,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboard,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Halo, ${widget.userName}!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Yuk, pantau keuanganmu hari ini.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // KARTU SALDO
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Saldo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _hideBalance = !_hideBalance;
                          });
                        },
                        icon: Icon(
                          _hideBalance
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isLoading)
                    const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  else
                    Text(
                      _hideBalance
                          ? 'Rp •••••••'
                          : _formatRupiah(_balance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 8),
                  const Text(
                    'Saldo dari seluruh transaksi',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Tambah Transaksi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // TOMBOL PEMASUKAN DAN PENGELUARAN
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    label: 'Pemasukan',
                    icon: Icons.arrow_downward,
                    color: Colors.green,
                    onTap: () {
                      _openAddTransaction(type: 'income');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    label: 'Pengeluaran',
                    icon: Icons.arrow_upward,
                    color: primaryColor,
                    onTap: () {
                      _openAddTransaction(type: 'expense');
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // TRANSAKSI TERBARU
            const Text(
              'Transaksi Terbaru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_transactions.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 44,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('Belum ada transaksi.'),
                    Text(
                      'Transaksimu akan muncul di sini.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
            else
              ..._transactions.map(
                (transaction) => Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          transaction.type == 'income'
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                      child: Icon(
                        transaction.type == 'income'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: transaction.type == 'income'
                            ? Colors.green
                            : primaryColor,
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${transaction.category} • ${transaction.date}',
                    ),
                    trailing: Text(
                      '${transaction.type == 'income' ? '+' : '-'}'
                      '${_formatRupiah(transaction.amount)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transaction.type == 'income'
                            ? Colors.green
                            : primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),

      // TOMBOL TAMBAH TRANSAKSI BEBAS PILIH JENIS
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTransaction(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}