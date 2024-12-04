import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable to track the theme mode
  var isDarkMode = false.obs;

  // Getter to determine the current theme mode
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Method to toggle the theme mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(theme);
  }
}
