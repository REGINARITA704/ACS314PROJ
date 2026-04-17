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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
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
                "Tasks for Selected Day",
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
              if (_selectedDay == null) {
                return const Center(
                  child: Text(
                    "Tap a day to see tasks",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              final List tasks = taskController.getTasksForDate(_selectedDay!);

              if (tasks.isEmpty) {
                return const Center(
                  child: Text(
                    "No tasks for this day",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.circle,
                      color: Color(0xFFFF99C8),
                      size: 12,
                    ),
                    title: Obx(
                      () => Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: task.isDone.value
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isDone.value ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                    trailing: Obx(
                      () => Checkbox(
                        activeColor: const Color(0xFF9B5DE5),
                        value: task.isDone.value,
                        onChanged: (_) => taskController.toggleTask(task),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController c = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("New Task"),
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
              if (c.text.trim().isNotEmpty && _selectedDay != null) {
                taskController.addTask(c.text.trim(), dueDate: _selectedDay!);
                Get.back();
              }
            },
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
