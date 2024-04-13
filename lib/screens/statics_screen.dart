import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<Goals>(context).goals;

    final completedTodoData = todoData.where((element) => element['completed']);
    final completedTodoList = completedTodoData.toList();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: LiquidCircularProgressIndicator(
                value: completedTodoData.length / todoData.length,
                valueColor: AlwaysStoppedAnimation(Colors.pink),
                direction: Axis.vertical,
                center: Text(
                    '${((completedTodoData.length * 100) / todoData.length).toInt()}%'), // value랑 같게
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: completedTodoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(completedTodoList[index]['todo']),
                      subtitle:
                          Text(completedTodoList[index]['date'].toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.refresh_rounded),
                        onPressed: () {
                          setState(() {
                            Provider.of<Goals>(context, listen: false)
                                .changeComplete(todoData[index]['id']);
                            Provider.of<Goals>(context, listen: false)
                                .changeTopPosition(todoData[index]['id']);
                            // isCompleted = !isCompleted;
                          });
                        },
                      ),
                    );
                  })),
        ],
      )),
    );
  }
}
