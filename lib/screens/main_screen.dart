import 'package:flutter/material.dart';
import 'package:todolist/providers/goals.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/set_goal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Goals>(
        builder: (context, goalsData, child) {
          final goals = goalsData.goals;
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              if (!goals[index]['completed']) {
                return GoalItem(
                  goal: goals[index]['goal']!,
                  todo: goals[index]['todo']!,
                  completed: goals[index]['completed']!,
                  onComplete: (bool completed) {
                    setState(() {
                      Provider.of<Goals>(context, listen: false).completeGoal(goals[index]['id']);
                    });
                  },
                  id: goals[index]['id'], // 이 부분도 추가
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
class GoalItem extends StatefulWidget {
  final String goal;
  final String todo;
  final bool completed;
  final Function(bool) onComplete;
  final int id;

  GoalItem({
    required this.goal,
    required this.todo,
    required this.completed,
    required this.onComplete,
    required this.id, // id 속
  });

  @override
  _GoalItemState createState() => _GoalItemState();
}
class _GoalItemState extends State<GoalItem> {

  @override
  Widget build(BuildContext context) {
    return  ListTile(
        title: Text(widget.goal),
        subtitle: Text(widget.todo),
        onTap: () {
            widget.onComplete(!widget.completed);
        },
    );
  }
}
