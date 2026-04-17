import 'dart:convert'; // Required for jsonEncode/Decode
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, String>> tasks = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks as soon as the app opens
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('saved_tasks');
    if (tasksString != null) {
      setState(() {
        List<dynamic> decodedList = jsonDecode(tasksString);
        tasks = decodedList
            .map((item) => Map<String, String>.from(item))
            .toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(tasks); // Convert list to string
    await prefs.setString('saved_tasks', encodedData);
  }

  void _addTask() {
    if (titleController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'title': titleController.text,
          'description': descriptionController.text,
        });
      });
      _saveTasks(); // Save after adding
      titleController.clear();
      descriptionController.clear();
      Navigator.of(context).pop();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks(); // Save after deleting
  }

  // ... (Keep your _showAddTaskDialog function the same as your original)
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(onPressed: _addTask, child: const Text('Add Task')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false, // Prevents going back to Sign Up
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks yet. Add one!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      tasks[index]['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(tasks[index]['description']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
