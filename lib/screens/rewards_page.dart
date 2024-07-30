// lib/screens/rewards_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:listapp/widgets/base_page.dart';

class RewardsPage extends StatelessWidget {
  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Mensagem"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _buyLife(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (taskProvider.coins >= 5) {
      taskProvider.buyLife();
      _showAlertDialog(context, "Compra efetuada com sucesso!");
    } else {
      _showAlertDialog(context, "Moedas insuficientes!");
    }
  }

  @override
  Widget build(BuildContext context) {
     return BasePage(
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView(
            children: [
              ListTile(
                leading: Image.asset('assets/images/reward_icon.png'),
                title: Text('Comprar uma vida'),
                subtitle: Text('5 coins'),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () => _buyLife(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}