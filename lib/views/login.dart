import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ Fixed: was get_x
import 'package:http/http.dart' as http;
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/to do list png.webp'),
              const SizedBox(height: 120),
              const Text(
                "Login Screen",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              const Text(
                "Enter username",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "username",
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Enter password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => passwordVisible = !passwordVisible),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text.trim();
                  String password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  try {
                    final response = await http.get(
                      Uri.parse(
                        "http://localhost/todo_api/login.php?email=$username&password=$password",
                      ),
                    );
                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      if (data['success'] == 1) {
                        // ✅ Go to HomeScreen (has bottom nav bar with dashboard)
                        Get.offAll(() => const HomeScreen());
                      } else {
                        Get.snackbar(
                          "Login Failed",
                          "Invalid credentials.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Error",
                        "Server error: ${response.statusCode}",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      "Error",
                      "Could not connect to server.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => Get.toNamed("/signup"),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Color.fromARGB(255, 90, 20, 54)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text("Forgot password?"),
                  const SizedBox(width: 8),
                  const Text(
                    "Reset",
                    style: TextStyle(color: Color.fromARGB(255, 90, 20, 54)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
