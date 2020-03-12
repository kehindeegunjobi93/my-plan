
class Task {

  String name;
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map toJson() => {
    'name': name,
    'isDone': isDone
  };

  Task.fromJson(Map json){
    name = json['name'];
    isDone = json['isDone'];
  }

}