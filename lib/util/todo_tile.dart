// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  Function(BuildContext)? editTask;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTask,
              icon: Icons.edit,
              backgroundColor: Colors.green.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        // startActionPane: ActionPane(
        //   motion: StretchMotion(),
        //   children: [
        //     SlidableAction(
        //       onPressed: completeTask,
        //       icon: Icons.done,
        //       backgroundColor: Colors.green.shade300,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ],
        // ),
        
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                //C H E C K B O X
                Checkbox(value: taskCompleted, onChanged: onChanged),
                //T A S K   N A M E
                Text(
                  taskName,
                  style: TextStyle(
                    decoration:
                        taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
