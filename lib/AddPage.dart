// ignore_for_file: prefer_const_constructors

import 'package:firebaseassessment/Todo.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formkey = GlobalKey<FormState>();
  void addcard() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
    Todo.add(_taskprio, _taskname);
    Navigator.pop(context);
  }

  String _taskname = "";
  int _taskprio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Addpage')),
      body: Center(
          child: Form(
        key: _formkey,
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Task name'),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Task name is needed';
              }
              return null;
            },
            onSaved: (newValue) => _taskname = newValue!,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Task prio'),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Task need a positive number';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            onSaved: (newValue) => _taskprio = int.parse(newValue!),
          ),
          ElevatedButton(
              onPressed: () {
                addcard();
              },
              child: Text("Save Card"))
        ]),
      )),
    );
  }
}
