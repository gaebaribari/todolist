import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Goals with ChangeNotifier {
  List<Map<String, dynamic>> goals = [];
  var cardSize = 400;

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
        'topPosition': MediaQuery.of(context).size.height / 16 + (i * 20),
        'sidePosition': 30.0 + (1 + i) * 5,
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

  void changePosition(BuildContext context, int date) {
    List<Map<String, dynamic>> beforeDate = goals
        .where((item) => date > item['date'] || (item['completed']))
        .toList();
    List<Map<String, dynamic>> afterDate = goals
        .where((item) => date <= item['date'] && !item['completed'])
        .toList();

    for (int i = 0; i < afterDate.length; i++) {
      afterDate[i]['sidePosition'] = 30.0 + (1 + i) * 5;
      afterDate[i]['topPosition'] =
          MediaQuery.of(context).size.height / 16 + (i * 20);
    }

    goals = [...beforeDate, ...afterDate];
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
