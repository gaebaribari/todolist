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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                TextFormField(
                  controller: _todoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '일주일 동안 집중할 한가지 행동을 적어주세요';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        '일주일 동안 집중할 한가지 행동을 적어주세요',
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 폼 유효성 검사 통과
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('시작하시겠습니까?'),
                            content: Text('작은 단위로 나눠야 움직이기 쉽습니다 '),
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
                  },
                child: Text('제출'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {

    String todo = _todoController.text;

    Goals goals = Provider.of<Goals>(context, listen:false);
    goals.addGoal(todo);
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>MainScreen()));

  }
}