import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final Map<DateTime, List<dynamic>> _events = {};

  Map<DateTime, List<dynamic>> get events => _events;

  void addEvent(DateTime date, dynamic event) {
    if (_events[date] == null) {
      _events[date] = [];
    }
    _events[date]!.add(event);
    notifyListeners();
  }

  void deleteEvent(DateTime date, dynamic event) {
    if (_events[date] != null) {
      _events[date]!.remove(event);
      if (_events[date]!.isEmpty) {
        _events.remove(date);
      }
      notifyListeners();
    }
  }
}
