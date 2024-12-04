// lib/screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final ProductController controller = Get.find();

  // Observable to track the quantity
  final RxInt quantity = 1.obs;

  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, height: 200, width: double.infinity),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Quantity controls under the product name
            Row(
              children: [
                const Text(
                  'Quantity:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8), // Add space between the label and buttons
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity.value > 1) {
                      quantity.value--;
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() => Text(
                    '${quantity.value}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    quantity.value++;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '\$${product.price}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.addToCart(product, quantity.value);
                Get.snackbar(
                  "Product Added",
                  "${product.title} (x${quantity.value}) has been added to your cart!",
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.7),
                  colorText: Colors.white,
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
