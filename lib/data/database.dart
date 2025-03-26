import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];

  //Reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time opening the app
  void createInitialData() {
    todoList = [
      ["Make ToDo app", false],
      ["Do Exercise", false],
    ];
  }

  //Load data from database

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", todoList);
  }
}
