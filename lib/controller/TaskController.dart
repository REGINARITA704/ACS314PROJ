import 'package:flutter_application_1/models/taskmodel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TaskController extends GetxController {
  final RxList<Task> _tasks = <Task>[].obs;

  List<Task> get allTasks => _tasks;
  List<Task> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((t) => t.isCompleted).toList();

  void addTask(String title, {DateTime? dueDate}) {
    _tasks.add(Task(title: title, dueDate: dueDate));
  }

  void toggleTaskStatus(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _tasks.refresh();
  }

  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    _tasks.refresh();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  void clearAllTasks() {
    _tasks.clear();
  }

  List<Task> getTasksForDate(DateTime? selectedDay) {
    if (selectedDay == null) return [];

    return _tasks.where((task) {
      if (task.dueDate == null) return false;

      return task.dueDate!.year == selectedDay.year &&
          task.dueDate!.month == selectedDay.month &&
          task.dueDate!.day == selectedDay.day;
    }).toList();
  }
}
