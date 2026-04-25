class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;
  DateTime? dueDate;

  Task({
    this.id,
    required this.title,
    this.description = "",
    this.isCompleted = false,
    this.dueDate,
  });

  Object? get length => null;
}
