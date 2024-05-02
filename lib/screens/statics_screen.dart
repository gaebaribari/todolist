import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:todolist/screens/set_goal_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dotted_line/dotted_line.dart';

class StaticsScreen extends StatefulWidget {


  // showButton 기준 : 마지막날 complete인경우 , 마지막날이 넘어간경우
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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE5FFD8), Color(0xFFFFBDBD)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: !widget.isLastDate,
          title: Text('리워드'),
        ),
        body: Center(
            child: Screenshot(
          controller: _controller,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                  child: LiquidCircularProgressIndicator(
                    value: completedTodoData.length / todoData.length,
                    valueColor: AlwaysStoppedAnimation(Color(0xffFFBFBF)),
                    direction: Axis.vertical,
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${((completedTodoData.length * 100) / todoData.length).toInt()}',
                            style: TextStyle(
                                fontFamily: 'Chab',
                                fontSize: 88,
                                color: Colors.black54)),
                        Text(
                          '%',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Chab',
                              color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: completedTodoList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${completedTodoList[index]['id']}일째 ${completedTodoList[index]['todo']}',
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      // bold하기
                                      completedTodoList[index]['memo'] != null
                                          ? Text(
                                              completedTodoList[index]['memo'])
                                          : Text(
                                              '메모를 입력해보세요',
                                              style: TextStyle(
                                                  color: Colors.black38),
                                            ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    alignment: Alignment.bottomLeft,
                                    icon: Icon(Icons.refresh_rounded),
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<Goals>(context,
                                                listen: false)
                                            .changeComplete(
                                                todoData[index]['id']);
                                      });
                                    },
                                  ),
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                lineLength: double.infinity,
                                lineThickness: 7.0,
                                dashLength: 14.0,
                                dashColor: Colors.transparent,
                                dashGapLength: 20.0,
                                dashGapColor: Colors.black26,
                                dashGapRadius: 3.0,
                              )
                            ],
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
      ),
    );
  }
}
