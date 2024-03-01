import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_app/Util/Dialago_box.dart';
import 'package:my_flutter_app/database/database.dart';

import '../Util/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box('mybox');
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }
// ###############################

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void checkCondition(String text, BuildContext context) {
    if (text == '') {
      showErrorDialog(context, "You didn't enter a Task Name");
    }
  }

// ###############################

  final _controller = TextEditingController();

  void CheckBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
      db.updateData();
    });
  }

  void saveNewTask() {
    setState(() {
      if (_controller.text != "") {
        db.ToDoList.add([_controller.text, false]);
        _controller.clear();
      } else {
        checkCondition(_controller.text, context);
        showErrorDialog(context, "You didn't enter a Task Name");
      }
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
          onSave: saveNewTask,
        );
      },
    );
  }

  void deleteFunction(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
      db.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("To Do"),
        backgroundColor: Colors.yellow,
        elevation: 7,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            TaskName: db.ToDoList[index][0],
            taskCompleted: db.ToDoList[index][1],
            onChanged: (value) => CheckBoxChanged(value, index),
            deleteTask: (context) => deleteFunction(index),
          );
        },
      ),
    );
  }
}
