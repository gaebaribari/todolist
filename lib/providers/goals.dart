import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Goals with ChangeNotifier {
  List<Map<String, dynamic>> goals = [];

  void addGoal(String todo) {
    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));

    var oneWeek = 7;
    for (int i = 0; i < oneWeek; i++) {
      goals.add({
        'id': 1+i,
        'todo': todo,
        'completed': false,
        'date': formattedDate+i,
      });
    }
    notifyListeners();
  }

  void completeGoal(int id) {
    final goalIndex = goals.indexWhere((goal) => goal['id'] == id);
    if (goalIndex != -1) {
      goals[goalIndex]['completed'] = !goals[goalIndex]['completed'];
      print(goals);
      notifyListeners();
    }
  }

}
