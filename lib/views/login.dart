import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // All controllers and variables must be declared here inside the State class
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  // Use localhost for your local PHP server
  final String baseUrl = "http://localhost/todo_api";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/to do list png.webp",
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  labelText: "Password".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () async {
                  String username = usernameController.text.trim();
                  String password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    Get.snackbar(
                      "Error".tr,
                      "Please fill in all fields".tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  try {
                    final response = await http.post(
                      Uri.parse("$baseUrl/login.php"),
                      body: {"username": username, "password": password},
                    );

                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      if (data['success'] == 1) {
                        Get.offAll(() => const HomeScreen());
                      } else {
                        Get.snackbar(
                          "Login Failed".tr,
                          data['message'] ?? "Invalid credentials.".tr,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Error".tr,
                        "Server error: ${response.statusCode}".tr,
                      );
                    }
                  } catch (e) {
                    Get.snackbar("Error".tr, "Could not connect to server.");
                  }
                },
                child: Text(
                  "Login".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
