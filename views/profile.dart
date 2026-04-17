import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. Controllers to handle the input text
  final TextEditingController _nameController = TextEditingController(
    text: "Name",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "student@university.edu",
  );
  final TextEditingController _passwordController = TextEditingController();

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                if (!_isEditing) {
                  // Logic to save data to your database/controller goes here
                  print("Saved: ${_nameController.text}");
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Prevents overflow when keyboard appears
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 30),

            // Name Field
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Email Field (Read only usually)
            TextField(
              controller: _emailController,
              enabled: false, // Usually email stays fixed
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field (Only shows if editing)
            if (_isEditing)
              TextField(
                controller: _passwordController,
                obscureText: true, // Hides password characters
                decoration: const InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                  hintText: "Enter new password",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
