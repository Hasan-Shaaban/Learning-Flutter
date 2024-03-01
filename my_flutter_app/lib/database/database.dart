import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List ToDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    ToDoList = [
      ["Hello to our App", false],
      ["Hello to our App", false],
    ];
  }

  void loadData() {
    ToDoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", ToDoList);
  }
}
