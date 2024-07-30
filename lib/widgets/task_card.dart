import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/models/task.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:intl/intl.dart';
import 'package:listapp/screens/register_page.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;

  TaskCard({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    bool isExpired = task.dueDate.isBefore(DateTime.now());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RegisterPage(task: task, taskIndex: index)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: task.isCompleted ? Colors.green : (isExpired ? Colors.red : Colors.purple), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              color: task.isCompleted ? Colors.green : (isExpired ? Colors.red : Colors.purple),
              decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            'Data Limite: ${DateFormat('dd/MM/yyyy').format(task.dueDate)}',
            style: TextStyle(
              color: task.isCompleted ? Colors.green : (isExpired ? Colors.red : Colors.purple),
            ),
          ),
          trailing: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_circle : (isExpired ? Icons.error : Icons.pending),
            color: task.isCompleted ? Colors.green : (isExpired ? Colors.red : Colors.purple),
          ),
          onPressed: () {
            if (!task.isCompleted) {
              taskProvider.taskCompletion(index);
            }
          }
          ),
        ),
      ),
    );
  }
}

