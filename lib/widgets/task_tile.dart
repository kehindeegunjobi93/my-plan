import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function deleteCallback;

  TaskTile({this.isChecked, this.taskTitle, this.checkboxCallback, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkboxCallback
      ),
      title: Text(taskTitle, style: TextStyle(
        decoration: isChecked ? TextDecoration.lineThrough : null
      ),),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: deleteCallback,
      ),
    );
  }
}


