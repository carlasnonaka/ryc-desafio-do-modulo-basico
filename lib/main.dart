import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:listapp/screens/home_page.dart';
import 'package:listapp/screens/rewards_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Jogo das Tarefas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          '/rewards': (context) => RewardsPage(),
        },
      ),
    );
  }
}

