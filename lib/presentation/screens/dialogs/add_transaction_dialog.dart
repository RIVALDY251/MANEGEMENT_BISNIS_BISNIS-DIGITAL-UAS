import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddTransactionDialog({
    required this.onAdd,
    super.key,
  });

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionCtrl;
  late TextEditingController _amountCtrl;
  late TextEditingController _categoryCtrl;

  String _selectedType = 'Pendapatan';
  String _selectedCategory = 'Penjualan';

  final Map<String, List<String>> _categoryByType = {
    'Pendapatan': ['Penjualan', 'Jasa', 'Bunga Bank', 'Investasi', 'Lainnya'],
    'Pengeluaran': ['Gaji', 'Pembelian Stok', 'Operasional', 'Utilitas', 'Iklan', 'Lainnya'],
  };

  @override
  void initState() {
    super.initState();
    _descriptionCtrl = TextEditingController();
    _amountCtrl = TextEditingController();
    _categoryCtrl = TextEditingController(text: _selectedCategory);
  }

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _amountCtrl.dispose();
    _categoryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Transaksi'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Type Selection
              const Text('Jenis Transaksi'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(label: Text('Pendapatan'), value: 'Pendapatan'),
                        ButtonSegment(label: Text('Pengeluaran'), value: 'Pengeluaran'),
                      ],
                      selected: {_selectedType},
                      onSelectionChanged: (selected) {
                        setState(() {
                          _selectedType = selected.first;
                          _selectedCategory = _categoryByType[_selectedType]!.first;
                          _categoryCtrl.text = _selectedCategory;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionCtrl,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Keterangan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Category Selection
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
                items: _categoryByType[_selectedType]!
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                      _categoryCtrl.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Amount Field
              TextFormField(
                controller: _amountCtrl,
                decoration: InputDecoration(
                  labelText: 'Jumlah (Rp)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Jumlah harus berupa angka';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final transactionData = {
                'type': _selectedType,
                'description': _descriptionCtrl.text,
                'category': _selectedCategory,
                'amount': int.parse(_amountCtrl.text),
              };
              widget.onAdd(transactionData);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaksi "$_selectedType" berhasil ditambahkan'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
