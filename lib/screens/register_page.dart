import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listapp/models/task.dart';
import 'package:listapp/provider/task_provider.dart';
import 'package:intl/intl.dart';
import 'package:listapp/widgets/base_page.dart';

class RegisterPage extends StatefulWidget {
  final Task? task;
  final int? taskIndex;

  RegisterPage({this.task, this.taskIndex});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedDate = widget.task!.dueDate;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _selectedDate!,
        isCompleted: widget.task?.isCompleted ?? false,
      );
      if (widget.taskIndex != null) {
        Provider.of<TaskProvider>(context, listen: false).updateTask(widget.taskIndex!, newTask);
      } else {
        Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      }
      Navigator.of(context).pop();
    }
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título da Tarefa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título!';
                  } else if (value.length < 3) {
                    return 'O título precisa ter no mínimo três caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _selectedDate == null
                        ? 'Selecione a Data Limite da Tarefa'
                        : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar a Tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
