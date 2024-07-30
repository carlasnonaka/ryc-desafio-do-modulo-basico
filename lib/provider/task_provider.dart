import 'package:flutter/material.dart';
import 'package:listapp/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  int _lives = 5;
  int _coins = 10;

  List<Task> get tasks => _tasks;
  int get lives => _lives;
  int get coins => _coins;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(int index, Task task) {
    _tasks[index].title = task.title;
    _tasks[index].description = task.description;
    _tasks[index].dueDate = task.dueDate;
    notifyListeners();
  }

  void taskCompletion(int index) {
    _tasks[index].isCompleted = true;
    if (_tasks[index].isCompleted) {
      _coins += 5;
    }
    notifyListeners();
  }

  void checkExpiredTasks() {
    DateTime now = DateTime.now();
    for (Task task in _tasks) {
      if (task.dueDate.isBefore(now) && !task.isCompleted) {
        task.isExpired = true;
        _lives -= 1;
      }
    }
    notifyListeners();
  }

   void buyLife() {
    if (_coins >= 5) {
      _coins -= 5;
      _lives++;
      notifyListeners();
    }
}
}