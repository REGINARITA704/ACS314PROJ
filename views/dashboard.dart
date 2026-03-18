import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "My Tasks",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _taskTile(
              "Complete Assignment",
              "Due: 5:00 PM",
              Icons.assignment,
              Colors.orange,
            ),
            _taskTile("Study Flutter", "Due: 8:00 PM", Icons.book, Colors.blue),
            _taskTile(
              "pick up kilimall package",
              "at 4:00 PM",

              Icons.shopping_cart_checkout,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskTile(String title, String time, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(time),
        trailing: const Icon(Icons.check_circle_outline),
      ),
    );
  }
}
