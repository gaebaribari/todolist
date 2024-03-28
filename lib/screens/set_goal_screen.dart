import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/main_screen.dart';
import 'package:todolist/providers/goals.dart';

class SetGoalScreen extends StatefulWidget {
  const SetGoalScreen({super.key});

  @override
  State<SetGoalScreen> createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _goalController = TextEditingController();
  TextEditingController _todoController = TextEditingController();
  bool _showTodoField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form 예제'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_showTodoField)
              TextFormField(
                controller: _goalController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이번주 동안 집중할 목표를 입력해 주세요';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: '이번주 동안 집중하고 싶은 한가지를 적어주세요',
                ),
                ),
              if (_showTodoField)
                TextFormField(
                  controller: _todoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '지금 당장 할 수 있는 작은 행동을 입력해 주세요';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        '${_goalController.text}를 위해 지금 당장 할수있는 작은 행동을 적어주세요',
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (!_showTodoField) {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _showTodoField = true; // 다음 단계로 넘어감
                      }
                    });
                  } else {
                    // 작은 할일 입력 후 제출
                    if (_formKey.currentState!.validate()) {
                      // 폼 유효성 검사 통과
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('작은할일 확인'),
                            content: Text('당장할 수 있는거 확실합니까?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('취소'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _submitForm();
                                },
                                child: Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text(_showTodoField ? '제출' : '다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {

    String goal = _goalController.text;
    String todo = _todoController.text;

    Goals goals = Provider.of<Goals>(context, listen:false);
    goals.addGoal(goal,todo);
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>MainScreen()));

  }
}