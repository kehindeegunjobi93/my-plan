import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:myplan/models/event.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class EventData extends ChangeNotifier{
  List<Event> _events = [];

  EventData(){
    initialState();
  }

  void initialState(){
    syncDataWithProvider();
  }

  UnmodifiableListView<Event> get events {
    return UnmodifiableListView(_events);
}

   int get eventCount {
     return _events.length;
   }

   void addEvent(String newEvent){
     final event = Event(task: newEvent);
     _events.add(event);
     updateSharedPreferences();
     notifyListeners();
   }

   void updateEvent(Event event){
    //event.toggleDone();
    updateSharedPreferences();
    notifyListeners();
   }

   void deleteEvent(Event event){
    _events.removeWhere((aevent) => aevent.task == event.task);
    updateSharedPreferences();
    notifyListeners();
   }

   Future updateSharedPreferences() async{
    List<String> myEvents = _events.map((f) => jsonEncode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('events', myEvents);
   }

   Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('events');

    if(result != null){
      _events = result.map((f) => Event.fromJson(jsonDecode(f))).toList();
    }

    notifyListeners();
   }
}