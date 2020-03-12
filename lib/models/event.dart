
class Event {
  String task;
  DateTime time;
  List<int> daySelector;
  bool runOnlyOnce;

  Event({this.task, this.runOnlyOnce = false});

//  void toggleDone() {
//    isFinish = !isFinish;
//  }

  Map toJson() => {
    'task': task,
   // 'isFinish': isFinish
  };

  Event.fromJson(Map json){
    task = json['task'];
    //isFinish = json['isFinish'];
  }

}