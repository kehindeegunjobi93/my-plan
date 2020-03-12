import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:myplan/models/task.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier{
  List<Task> _tasks = [];

  TaskData(){
    initialState();
  }

  void initialState(){
    syncDataWithProvider();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
}

  UnmodifiableListView<Task> get incompleteTasks {
    return UnmodifiableListView(_tasks.where((todo) => !todo.isDone));
  }

  UnmodifiableListView<Task> get completedTasks {
    return UnmodifiableListView(_tasks.where((todo) => todo.isDone));
  }

   int get taskCount {
     return _tasks.length;
   }

   void addTask(String newTaskTitle){
     final task = Task(name: newTaskTitle);
     _tasks.add(task);
     updateSharedPreferences();
     notifyListeners();
   }

   void updateTask(Task task){
    task.toggleDone();
    updateSharedPreferences();
    notifyListeners();
   }

   void toggleTask(Task task){
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleDone();
    updateSharedPreferences();
    notifyListeners();
   }

   void deleteTask(Task task){
    _tasks.removeWhere((atask) => atask.name == task.name);
    updateSharedPreferences();
    notifyListeners();
   }

   Future updateSharedPreferences() async{
    List<String> myTasks = _tasks.map((f) => jsonEncode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('tasks', myTasks);
   }

   Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('tasks');

    if(result != null){
      _tasks = result.map((f) => Task.fromJson(jsonDecode(f))).toList();
    }

    notifyListeners();
   }
}