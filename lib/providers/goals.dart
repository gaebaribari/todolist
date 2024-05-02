import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Goals with ChangeNotifier {
  List<Map<String, dynamic>> goals = [];

  void addGoal(context, String todo) {
    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));

    var oneWeek = 7;
    for (int i = 0; i < oneWeek; i++) {
      goals.add({
        'id': 1 + i,
        'todo': todo,
        'completed': false,
        'date': formattedDate + i,
        'memo': null,
      });
    }
    notifyListeners();
  }

  void changeComplete(int id) {
    final goalIndex = goals.indexWhere((goal) => goal['id'] == id);
    if (goalIndex != -1) {
      goals[goalIndex]['completed'] = !goals[goalIndex]['completed'];
      notifyListeners();
    }
  }

  void saveTodayMemo(String memoText) {
    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));
    final goalIndex = goals.indexWhere((goal) => goal['date'] == formattedDate);
    if (goalIndex != -1) {
      goals[goalIndex]['memo'] = memoText;
      notifyListeners();
    }
  }
}
