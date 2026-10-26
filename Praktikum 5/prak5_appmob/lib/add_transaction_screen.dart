import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _tanggalController = TextEditingController();

  Future<void> _pilihTanggal() async {
    DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (tanggal != null) {
      setState(() {
        _tanggalController.text =
            "${tanggal.day.toString().padLeft(2, '0')}/"
            "${tanggal.month.toString().padLeft(2, '0')}/"
            "${tanggal.year}";
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catat Transaksi"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input judul transaksi
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Judul tidak boleh kosong";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Input nominal transaksi
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Nominal",
                  prefixText: "Rp ",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nominal tidak boleh kosong";
                  }

                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return "Masukkan nominal yang valid";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Input tanggal transaksi
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Tanggal Transaksi",
                  hintText: "DD/MM/YYYY",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _pilihTanggal,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal transaksi wajib diisi";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Tombol simpan transaksi
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Transaksi Berhasil Disimpan!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context, {
                      'title': _titleController.text.trim(),
                      'amount': _amountController.text,
                      'date': _tanggalController.text,
                    });
                  }
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}