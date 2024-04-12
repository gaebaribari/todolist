import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Goals with ChangeNotifier {
  List<Map<String, dynamic>> goals = [];
  final initialTopPosition = 130.0;

  void addGoal(String todo) {
    var now = DateTime.now();

    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));

    var oneWeek = 7;
    for (int i = 0; i < oneWeek; i++) {
      goals.add({
        'id': 1 + i,
        'todo': todo,
        'completed': false,
        'date': formattedDate + i,
        'topPosition': initialTopPosition + 10.0 * i,
        'sidePosition':10.0 * (i+1)

      });
    }
    notifyListeners();
  }

  void completeGoal(int id) {
    final goalIndex = goals.indexWhere((goal) => goal['id'] == id);
    if (goalIndex != -1) {
      goals[goalIndex]['completed'] = !goals[goalIndex]['completed'];
      notifyListeners();
    }
  }

  void changeTopPosition(int id) {
 var i = 0;
        for (Map<String, dynamic> map in goals) {

      if (map['id'] != id && !map['completed'] ) {
        map['topPosition'] = initialTopPosition + 10.0 * i;
        map['sidePosition'] = 10.0 * (i+1);
        i += 1;
      }
    }
 notifyListeners();
  }
}
