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
        'sidePosition': 10.0 * (i + 1),
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

  void changeTopPosition(int date) {
    List<Map<String, dynamic>> beforeToday = [
      ...goals
          .where((item) => item['date'] < date && !item['completed'])
          .toList()
        ..sort((a, b) => a['date'].compareTo(b['date']))
    ];

    // 오름차순
    List<Map<String, dynamic>> afterToday = [
      ...goals
          .where((item) => item['date'] >= date && !item['completed'])
          .toList()
        ..sort((a, b) => a['date'].compareTo(b['date']))
    ];
    List sortedGoals = [...afterToday, ...beforeToday];

    var i = 0;
    for (Map<String, dynamic> map in sortedGoals) {
      map['topPosition'] = initialTopPosition + 10.0 * i;
      map['sidePosition'] = 10.0 * (i + 1);
      i += 1;
    }
    notifyListeners();
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
