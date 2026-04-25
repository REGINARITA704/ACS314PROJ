import 'package:get/get.dart';

class Task {
  final String title;
  final DateTime? dueDate;
  bool isCompleted;

  Task({required this.title, this.dueDate, this.isCompleted = false});
}

class TaskController extends GetxController {
  final tasks = <Task>[].obs;

  void addTask(String title, {DateTime? dueDate}) {
    tasks.add(Task(title: title, dueDate: dueDate));
  }

  void toggleTaskStatus(Task task) {
    task.isCompleted = !task.isCompleted;
    tasks.refresh();
  }

  // Same as toggleTaskStatus — used by calendar
  void toggleTaskStatusByObject(Task task) {
    task.isCompleted = !task.isCompleted;
    tasks.refresh();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }

  void clearAllTasks() {
    tasks.clear();
  }

  List<Task> getTasksForDate(DateTime date) {
    return tasks
        .where(
          (t) =>
              t.dueDate != null &&
              t.dueDate!.year == date.year &&
              t.dueDate!.month == date.month &&
              t.dueDate!.day == date.day,
        )
        .toList();
  }
}
