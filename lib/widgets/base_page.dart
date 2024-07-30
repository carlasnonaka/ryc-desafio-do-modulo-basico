import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:listapp/screens/home_page.dart';
import 'package:listapp/screens/rewards_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;

  BasePage({required this.child, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            CircleAvatar(              
              backgroundImage: AssetImage('assets/images/user_photo.png')
            ),
            SizedBox(width: 10),
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                return Row(
                  children: [
                    Icon(Icons.favorite, color: taskProvider.lives >= 1 ? Colors.red : Colors.grey),
                    Icon(Icons.favorite, color: taskProvider.lives >= 2 ? Colors.red : Colors.grey),
                    Icon(Icons.favorite, color: taskProvider.lives >= 3 ? Colors.red : Colors.grey),
                    Icon(Icons.favorite, color: taskProvider.lives >= 4 ? Colors.red : Colors.grey),
                    Icon(Icons.favorite, color: taskProvider.lives >= 5 ? Colors.red : Colors.grey),
                    SizedBox(width: 10),
                    Icon(Icons.attach_money_rounded , color: Colors.yellowAccent),
                    Text('${taskProvider.coins}', style: TextStyle(color: Colors.yellowAccent)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RewardsPage()),
            );
          }
        },
      ),
    );
  }
}
