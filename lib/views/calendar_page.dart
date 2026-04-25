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
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 127, 19, 85),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        onPressed: () => _showAddDialog(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Tasks for Selected Day",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(() {
                // Access tasks.value to make Obx reactive

                taskController.tasks.value;

                final currentTasks = taskController.getTasksForDate(
                  _selectedDay ?? DateTime.now(),
                );

                if (currentTasks.isEmpty) {
                  return const Center(child: Text("No tasks for this day"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: currentTasks.length,
                  itemBuilder: (context, index) {
                    final task = currentTasks[index];
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(
                          task.isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                        ),
                        onPressed: () => taskController.toggleTaskStatus(task),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Task"),
        content: TextField(controller: c),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (c.text.trim().isNotEmpty) {
                taskController.addTask(c.text.trim(), dueDate: _selectedDay);
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
