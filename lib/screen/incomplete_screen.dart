import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myplan/provider/task_data.dart';
import 'package:myplan/widgets/task_tile.dart';

class InCompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.incompleteTasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              deleteCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.incompleteTasks.length,
        );
      },
    );
  }
}
