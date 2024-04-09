import 'package:flutter/material.dart';
import 'package:todolist/providers/goals.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
                  todo: goals[index]['todo']!,
                  completed: goals[index]['completed']!,
                  onComplete: (bool completed) {
                    setState(() {
                      Provider.of<Goals>(context, listen: false).completeGoal(goals[index]['id']);
                    });
                  },
                  id: goals[index]['id'],
                  date: goals[index]['date'], //// 이 부분도 추가
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


//활성화 될땐 색깔 다르게 보이게 하자
class CustomDisabledFAB extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool isEnabled; // 활성화 여부 추가
  final Color enabledBackgroundColor;
  final Color disabledBackgroundColor;

  const CustomDisabledFAB({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.isEnabled,
    this.enabledBackgroundColor = Colors.blue, // 활성화된 경우의 기본 배경색
    this.disabledBackgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  _CustomDisabledFABState createState() => _CustomDisabledFABState();
}

class _CustomDisabledFABState extends State<CustomDisabledFAB> {
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _enabled = widget.isEnabled;
  }

  @override
  void didUpdateWidget(covariant CustomDisabledFAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    _enabled = widget.isEnabled;
  }


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _enabled ? widget.onPressed : null,
      child: widget.child,
      backgroundColor:  _enabled ? widget.enabledBackgroundColor : widget.disabledBackgroundColor,
      elevation:  _enabled ? 6.0 : 0.0,
    );
  }

}


class GoalItem extends StatefulWidget {

  final String todo;
  final bool completed;
  final Function(bool) onComplete;
  final int id;
  final int date;

  GoalItem({
    required this.todo,
    required this.completed,
    required this.onComplete,
    required this.id, // id 속
    required this.date,
  });

  @override
  _GoalItemState createState() => _GoalItemState();
}
class _GoalItemState extends State<GoalItem> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = (int.parse(DateFormat('yyMMdd').format(DateTime.now()))) == widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return  ListTile(
        title: Text('${widget.id}'),
        subtitle: Text(widget.todo),
      trailing:   CustomDisabledFAB(
          isEnabled: _isEnabled, // 활성화 여부 설정
          onPressed: _isEnabled
              ? () {
            widget.onComplete(!widget.completed);
          }
              : null,
          child: Icon(Icons.check),
          enabledBackgroundColor: Colors.blue, // 활성화된 경우의 배경색
          disabledBackgroundColor: Colors.grey, // 비활성화된 경우의 배경색/  사용자 지정 배경색
        ),
    );
  }
}
