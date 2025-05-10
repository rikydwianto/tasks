import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/productdetail_controller.dart';

class ProductdetailView extends GetView<ProductdetailController> {
  final String productId;

  // Konstruktor untuk menerima productId
  const ProductdetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product ID: $productId',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Kamu bisa menambahkan lebih banyak informasi produk di sini
            const Text(
              'Product detail information will be shown here...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
