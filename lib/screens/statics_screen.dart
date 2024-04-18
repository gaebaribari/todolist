import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:todolist/screens/set_goal_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class StaticsScreen extends StatefulWidget {
  final bool isLastDate;

  const StaticsScreen({Key? key, required this.isLastDate}) : super(key: key);

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  late ScreenshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScreenshotController();
  }

  Future<void> _captureAndSavePng() async {
    try {
      final capturedImage = await _controller.capture();
      if (capturedImage != null) {
        // 체크해서 null인지 확인
        await ImageGallerySaver.saveImage(capturedImage);
        print('Image saved to gallery.');
      } else {
        print('Captured image is null.');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<Goals>(context).goals;

    final completedTodoData = todoData.where((element) => element['completed']);
    final completedTodoList = completedTodoData.toList();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Screenshot(
        controller: _controller,
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
                        title: Text(
                            '${completedTodoList[index]['id']} ${completedTodoList[index]['todo']}'),
                        subtitle: widget.isLastDate
                            ? Text(completedTodoList[index]['memo'] ?? '')
                            : null,
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
            widget.isLastDate
                ? Expanded(
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: _captureAndSavePng,
                            child: Text('PNG 저장하기')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SetGoalScreen()),
                              );
                            },
                            child: Text('새로운 일주일 시작하기')),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      )),
    );
  }
}
