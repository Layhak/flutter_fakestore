import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var cart = <CartItem>[].obs;  // Ensure this is a list of CartItem
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        products.value = jsonData.map((json) => Product.fromJson(json)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  void addToCart(Product product, int quantity) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cart[index].quantity += quantity;
    } else {
      cart.add(CartItem(product: product, quantity: quantity));
    }
  }

  void removeFromCart(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
  }

  double get totalPrice => cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
