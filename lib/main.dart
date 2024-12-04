import 'package:flutter/material.dart';
import 'package:flutter_fakestore/screens/cart_screen.dart';
import 'package:get/get.dart';
import 'controllers/product_controller.dart';
import 'controllers/theme_controller.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'FakeStore App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green.withOpacity(0.7),
          contentTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
      themeMode: themeController.theme,
      home: const ProductListScreen(),
    ));
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController productController = Get.put(ProductController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Obx(() => IconButton(
            icon: Icon(themeController.isDarkMode.value
                ? Icons.wb_sunny
                : Icons.nightlight_round),
            onPressed: () {
              themeController.toggleTheme();
            },
          )),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              leading: Image.network(product.image, width: 50, height: 50),
              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
              onTap: () {
                Get.to(() => ProductDetailScreen(product: product));
              },
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  productController.addToCart(product, 1);
                  Get.snackbar(
                    "Product Added",
                    "${product.title} has been added to your cart!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.withOpacity(0.7),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
