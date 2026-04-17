import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class SignupController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  void signupUser() {
    String name = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      Get.snackbar(
        "Success",
        "Account created for $name",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = true;

      Get.offAll(() => const Dashboard_screen());
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
