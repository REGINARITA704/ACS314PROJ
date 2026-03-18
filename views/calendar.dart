import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "Schedule",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                "March 2026",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 31,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index == 12 ? Colors.red : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: index == 12 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
              const Text(
                "Upcoming Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Adding some extra items to test the scrolling
              _eventTile(" Flutter Project Due", "11:59 PM", Colors.red),
              _eventTile("Gym ", "06:00 PM", Colors.blue),
              _eventTile("visit friend", "08:30 PM", Colors.orange),

              const SizedBox(height: 100), // Space for the Navigation Bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventTile(String title, String time, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(width: 5, height: 40, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time),
    );
  }
}
