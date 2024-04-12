import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';

class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<Goals>(context).goals;
    List<Map<String, dynamic>> reversedTodoData = todoData.reversed.toList();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.red,
              // 통계페이지
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: todoData.length,
            itemBuilder: (context, index) {
              if (todoData[index]['completed']) {
                print(todoData[index]['completed']);
                return ListTile(
                  title: Text(todoData[index]['todo']),
                  subtitle: Text(todoData[index]['date'].toString()),
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
              }
            },
          )),
        ],
      )),
    );
  }
}
