import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/TaskController.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';



class MovingCalendar extends StatefulWidget {
  const MovingCalendar({super.key});

  @override
  State<MovingCalendar> createState() => _MovingCalendarState();
}

class _MovingCalendarState extends State<MovingCalendar> {
  final TaskController taskController = Get.find<TaskController>();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9B5DE5),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        onPressed: () => _showAddDialog(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (sel, foc) => setState(() {
              _selectedDay = sel;
              _focusedDay = foc;
            }),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF9B5DE5),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFFF99C8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pending Tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4E69),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              var pending = taskController.pendingTasks;
                  
              return ListView.builder(
                itemCount: pending?.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(
                    Icons.circle,
                    color: Color(0xFFFF99C8),
                    size: 12,
                  ),
                  title: Text(
                    pending [int index].title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                 
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("New Future Task"),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(hintText: "What needs to be done?"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9B5DE5),
            ),
            onPressed: () {
              taskController.addTask(c.text, "Scheduled");
              Get.back();
            },
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

extension on Object? {
  int? get length => null;
}


