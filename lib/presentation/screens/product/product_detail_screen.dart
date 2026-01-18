import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  final bool isEdit;

  const ProductDetailScreen({
    super.key,
    this.product,
    this.isEdit = false,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!['name'] ?? '';
      _priceController.text = (widget.product!['price'] ?? 0).toString();
      _stockController.text = (widget.product!['stock'] ?? 0).toString();
      _categoryController.text = widget.product!['category'] ?? '';
      _descriptionController.text = widget.product!['description'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Mock save
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEdit
                ? 'Produk berhasil diperbarui'
                : 'Produk berhasil ditambahkan',
          ),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image Placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 60,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () {
                        // Pick image
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tambah Gambar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Form Fields
              AppTextField(
                label: 'Nama Produk',
                controller: _nameController,
                prefixIcon: const Icon(Icons.inventory_2),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Harga',
                controller: _priceController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.attach_money),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Stok',
                controller: _stockController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.warehouse),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Stok harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Kategori',
                controller: _categoryController,
                prefixIcon: const Icon(Icons.category),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Deskripsi',
                controller: _descriptionController,
                maxLines: 4,
                prefixIcon: const Icon(Icons.description),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: widget.isEdit ? 'Simpan Perubahan' : 'Tambah Produk',
                onPressed: _saveProduct,
                isLoading: _isLoading,
                width: double.infinity,
              ),
              if (widget.isEdit) ...[
                const SizedBox(height: 16),
                AppButton(
                  label: 'Hapus Produk',
                  type: AppButtonType.outline,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hapus Produk'),
                        content: const Text(
                          'Apakah Anda yakin ingin menghapus produk ini?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                            ),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );
                  },
                  width: double.infinity,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
