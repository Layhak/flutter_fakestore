```markdown
# FakeStore App

This project is a simple e-commerce application built using Flutter and GetX for state management. It demonstrates how to manage product listings, a shopping cart, and theme switching.

## Features

- **Product List**: Display a list of products fetched from an API.
- **Product Detail**: View detailed information about each product.
- **Shopping Cart**: Add products to the cart, adjust quantities, and checkout.
- **Theme Switching**: Toggle between light and dark modes.

# GetX Functions Used in the Project

This project utilizes several key functions from the GetX package to manage state, navigation, and user feedback effectively.

## Key GetX Functions

### 1. State Management with `.obs`

-  **Reactive Variables**: GetX provides reactive state management using the `.obs` extension. This allows variables to be reactive and automatically update the UI when their values change.

  ```dart
  var products = <Product>[].obs;
  var cart = <CartItem>[].obs;
  var isLoading = true.obs;
  ```
	•	Usage: Reactive variables are used in controllers to manage the state of products, cart items, and loading indicators.
### 2. Controllers
	•	GetxController: Controllers in GetX manage the business logic and state of the application. They are used to encapsulate functionality and maintain a clean separation of concerns.
```dart
class ProductController extends GetxController {
  // Logic for fetching products and managing cart
}
```
	•	Dependency Injection: Controllers are instantiated and accessed using Get.put() and Get.find() for efficient dependency management.
### 3. Navigation
	•	Get.to(): This function is used for navigating between screens. It simplifies navigation by handling the routing internally.
```dart
    Get.to(() => ProductDetailScreen(product: product));
```
    •	Get.back(): Used to return to the previous screen, making it easy to implement back navigation.
```dart
Get.back()
```

### 4. Theme Management

- **Dynamic Themes**: Use `Get.changeThemeMode()` to toggle between light and dark themes.

```dart
void toggleTheme() {
  isDarkMode.value = !isDarkMode.value;
  Get.changeThemeMode(theme);
}
```

## Setup

1. **Clone the Repository**: Clone the project to your local machine.

```bash
git clone <repository-url>
```

2. **Install Dependencies**: Navigate to the project directory and run:

```bash
flutter pub get
```

3. **Run the App**: Use the following command to run the app on an emulator or connected device.

```bash
flutter run
```

## API Integration

The app fetches product data from a fake store API. Ensure you have an internet connection to load the product list.

## Telegram Integration

The app can send cart details to a Telegram group using the Telegram Bot API. Configure your bot token and chat ID in the `sendCartToTelegram` method.

## Conclusion

This project showcases the power of GetX for building a responsive and maintainable Flutter application. It covers essential features like state management, navigation, and user feedback through snackbars.
```