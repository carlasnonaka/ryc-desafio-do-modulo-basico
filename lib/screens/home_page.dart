import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:listapp/widgets/task_card.dart';
import 'package:listapp/widgets/base_page.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).checkExpiredTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskCard(task: task, index: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
      ),
    );
  }
}

