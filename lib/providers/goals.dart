import 'package:flutter/material.dart';

class Goals with ChangeNotifier {
  List<Map<String, dynamic>> goals = [];
  int _nextId = 1;

  void addGoal(String goal, String todo) {
    goals.add({
      'id': _nextId,
      'goal': goal,
      'todo': todo,
      'completed': false,
      'isTopPriority' : false,
    });
    _nextId++;
    notifyListeners();
  }

  void completeGoal(int id) {
    final goalIndex = goals.indexWhere((goal) => goal['id'] == id);
    if (goalIndex != -1) {
      goals[goalIndex]['completed'] = !goals[goalIndex]['completed'];
      notifyListeners();
    }
  }

  void changedTopPriority(int id) {
    final topPriorityIndex = goals.indexWhere((goal) => goal['isTopPriority'] == id);
    if (topPriorityIndex == -1) {
      for (var goal in goals) {
          goal['isTopPriority'] = false;
        }

    }
    final goalIndex = goals.indexWhere((goal) => goal['id'] == id);
    if (goalIndex != -1) {
      goals[goalIndex]['isTopPriority'] = true;
    }
    print(goals.map((goal) => goal['isTopPriority']).toList());
    notifyListeners();
  }
}
