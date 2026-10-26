import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  String _formatRupiah(double amount) {
    final value = amount.abs().toStringAsFixed(0);

    final formatted = value.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFE53935);

    final isIncome = transaction.type == 'income';
    final typeColor = isIncome ? Colors.green : primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 42,
              backgroundColor: isIncome
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              child: Icon(
                isIncome
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                size: 42,
                color: typeColor,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              transaction.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '${isIncome ? '+' : '-'}'
              '${_formatRupiah(transaction.amount)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: typeColor,
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _detailRow(
                    'Jenis transaksi',
                    isIncome ? 'Pemasukan' : 'Pengeluaran',
                  ),
                  const Divider(height: 28),
                  _detailRow(
                    'Kategori',
                    transaction.category,
                  ),
                  const Divider(height: 28),
                  _detailRow(
                    'Tanggal',
                    transaction.date,
                  ),
                  const Divider(height: 28),
                  _detailRow(
                    'ID transaksi',
                    transaction.id?.toString() ?? '-',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}