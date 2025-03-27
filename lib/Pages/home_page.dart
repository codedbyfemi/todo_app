import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //R E F E R E N C E   T H E   H I V E   B O X
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  //T E X T   C O N T R O L L E R
  final _controller = TextEditingController();

  //L I S T   O F    T O D O    T A S K S

  //C H E C K B O X   W A S   T A P P E D
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  //S A V E   N E W   T A S K
  void saveNewTask() {
    setState(() {
      if (_controller.text.isEmpty) {
        Navigator.pop;
      } else {
        db.todoList.add([_controller.text, false]);
      }
    });
    Navigator.pop(context);
    _controller.clear();
    db.updateDataBase();
  }

  //C R E A T E   A   N E W  T A S K
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  //D E L E T E   T A S K
  void delete(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // C O M P L E T E   T A S K
  void editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              if (_controller.text.isEmpty) {
                Navigator.pop;
              } else {
                db.todoList[index][0] = _controller.text;
              }
            });
            Navigator.pop(context);
            _controller.clear();
            db.updateDataBase();
          },
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("TO DO")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: CircleBorder(),
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => delete(index),
            editTask: (context) => editTask(index),
          );
        },
      ),
    );
  }
}
