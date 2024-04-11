import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<Goals>(context).goals;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.edit_note_outlined), // 연필에 추가 아이콘 없나 좀 동글동글한
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.bar_chart_rounded),
              onPressed: () {
                // 새로운 다트 페이지 만들기 (todo chart page? 이런느낌)
              }),
        ],
      ),
      body: Center(
        child: Stack(
          children:
              todoData.reversed.where((item) => !item['completed']).map((item) {
            var index = item['id'];
            var cardWidth = 300 - 40.0 * (index);
            return Positioned(
              top: 130 + 20.0 * index,
              left: (MediaQuery.of(context).size.width - cardWidth) / 2,
              child: Column(
                children: [
                  Text(item['todo']),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<Goals>(context, listen: false)
                            .completeGoal(item['id']);
                        // isCompleted = !isCompleted;
                      });
                    },
                    child: Text('완수'),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
