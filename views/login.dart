import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:http/http.dart' as http;

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
              //Obx(
              //() =>
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
              // ),
              const SizedBox(height: 30),
              // Replaced GestureDetector + Container with ElevatedButton for better feedback
              ElevatedButton(
                onPressed: () async {
                  Get.offAllNamed('/homescreen');

                  print(
                    "Login button pressed",
                  ); // Debug: Check console for this
                  usernameController.text.trim();
                  passwordController.text;

                  final response = await http.get(
                    Uri.parse(
                      "http://localhost/todo_api/login.php?email=${usernameController.text.trim()}&password=${passwordController.text}",
                    ),
                  );
                  if (response.statusCode == 200) {
                    var data = jsonDecode(response.body);
                    if (data['success'] == 1) {
                      //Get.snackbar("Login Successful", "Welcome back!");
                      Get.toNamed("/homescreen");
                    } else {
                      Get.snackbar("Login Failed", "Invalid credentials.");
                    }
                  } else {
                    Get.snackbar(
                      "Login Failed",
                      "SERVER ERROR: ${response.statusCode}",
                    );
                  }

                  //print(response.body);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50), // Full width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                  ), // Changed to visible color
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
