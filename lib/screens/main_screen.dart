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
  bool activeChangedTopPriorityButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.star),
          onPressed: (){
            setState(() {
              activeChangedTopPriorityButton = true;
            });
          },
        ),
      ),
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
                  activeChangedTopPriorityButton: activeChangedTopPriorityButton, // 이 부분 추가
                  changedTopPriority: (int id) {
                    Provider.of<Goals>(context, listen: false).changedTopPriority(id);
                    activeChangedTopPriorityButton = false;
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
      floatingActionButton: Consumer<Goals>(
        builder: (context, goalsData, child) {
          return FloatingActionButton(
            onPressed: () {
              // if (goalsData.goals.length >= 3) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('목표 추가 한도를 초과했습니다.'),
              //       duration: Duration(seconds: 2),
              //       behavior: SnackBarBehavior.floating,
              //       margin: EdgeInsets.symmetric(horizontal: 50),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //     ),
              //   );
              // } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetGoalScreen()),
                );
              // }
            },
            child: Icon(Icons.add),
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
  final bool activeChangedTopPriorityButton;
  final Function(int) changedTopPriority;
  final int id;

  GoalItem({
    required this.goal,
    required this.todo,
    required this.completed,
    required this.onComplete,
    required this.activeChangedTopPriorityButton,
    required this.changedTopPriority,
    required this.id, // id 속
  });

  @override
  _GoalItemState createState() => _GoalItemState();
}
class _GoalItemState extends State<GoalItem> {

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.goal),
      onDismissed: (direction) {
        setState(() {
          widget.onComplete(!widget.completed);
        });
      },
      child: ListTile(
        title: Text(widget.goal),
        subtitle: Text(widget.todo),
        onTap: () {
          if(widget.activeChangedTopPriorityButton){
            widget.changedTopPriority(widget.id);
          }else{
            widget.onComplete(!widget.completed);
          }
        },
      ),
    );
  }
}
