import 'package:get/get.dart';

class Task {
  String title;

  RxBool isDone;

  Task({required this.title, bool done = false}) : isDone = done.obs;

  Null get isCompleted => null;

  Null get time => null;
}

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var totalAddedEver = 0.obs;
  var totalCompletedEver = 0.obs;

  int get pendingTasksCount => tasks.where((task) => !task.isDone.value).length;
  int get currentCompletedCount =>
      tasks.where((task) => task.isDone.value).length;

  Object? get pendingTasks => null;

  void addTask(String title, String s) {
    tasks.add(Task(title: title));
    totalAddedEver.value++;
  }

  void toggleTask(Task task) {
    task.isDone.value = !task.isDone.value;
    if (task.isDone.value) {
      totalCompletedEver.value++;
    } else {
      totalCompletedEver.value--;
    }
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
