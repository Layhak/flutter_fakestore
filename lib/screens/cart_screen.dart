import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';  // Import the intl package
import '../controllers/product_controller.dart';

class CartScreen extends StatelessWidget {
  final ProductController productController = Get.find();

  CartScreen({super.key});

  Future<void> sendCartToTelegram() async {
    const String botToken = '7854500204:AAFYmP7y9be7kdgWlROb1dmf6MTKh4Ae3fE';
    const String chatId = '-4732379187';

    String cartDetails = productController.cart.map((cartItem) {
      return '${cartItem.product.title} x ${cartItem.quantity} - \$${cartItem.product.price * cartItem.quantity}';
    }).join('\n');

    String message = 'Cart Details:\n$cartDetails\nTotal: \$${productController.totalPrice}';
    const url = 'https://api.telegram.org/bot$botToken/sendMessage';
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'chat_id': chatId, 'text': message}),
    );

    productController.cart.clear();
    Get.snackbar(
      "Checkout Complete",
      "Your order has been processed!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: productController.cart.length,
          itemBuilder: (context, index) {
            final cartItem = productController.cart[index];
            return ListTile(
              leading: Image.network(cartItem.product.image, width: 50, height: 50),
              title: Text(cartItem.product.title),
              subtitle: Text('\$${cartItem.product.price} x ${cartItem.quantity}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        cartItem.quantity--;
                      } else {
                        productController.cart.removeAt(index);
                      }
                      productController.cart.refresh();
                    },
                  ),
                  Text('${cartItem.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartItem.quantity++;
                      productController.cart.refresh();
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final formattedTotal = NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 2,  // Set decimal digits to 2
        ).format(productController.totalPrice);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: $formattedTotal',
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: sendCartToTelegram,
                child: const Text('Checkout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
