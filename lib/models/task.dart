class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  bool isExpired;

  Task({
    required this.title,
    this.description = '',
    required this.dueDate,
    this.isCompleted = false,
    this.isExpired = false,
  });
}
