import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/memo_screen.dart';
import 'package:todolist/screens/statics_screen.dart';
import 'package:glass_kit/glass_kit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> todoData = Provider.of<Goals>(context).goals;

    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));
    int lastDate = formattedDate + 7;

    if (formattedDate > lastDate) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => (StaticsScreen(
                    isLastDate: true,
                  ))),
        );
      });
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE5FFD8), Color(0xFFFFBDBD)],
        ),
      ),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 50),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.bar_chart_rounded),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StaticsScreen(isLastDate: false)));
              },
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              ...todoData
                  .where((item) =>
                      item['date'] >= formattedDate && !item['completed'])
                  .take(3)
                  .map((item) {
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      top: item['topPosition'],
                      left: item['sidePosition'],
                      right: item['sidePosition'],
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              spreadRadius: 4,
                              offset: const Offset(1, 4),
                            )
                          ], // 그림자의 위치
                        ),
                        width: item['cardWidth'],
                        child: GlassContainer(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          blur: 400,
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: 350,
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.80),
                              Colors.white.withOpacity(0.20),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.60),
                              Colors.white.withOpacity(0.10),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 8.0,
                          shadowColor: Colors.black.withOpacity(0.20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${item['id']}일째', style: TextStyle(
                                color: Colors.black38,
                              ),),//아니다 회색으로
                              Text('${item['todo']}'),
                              GlassContainer(
                                height: 70,
                                width: 350,
                                margin: EdgeInsets.symmetric(
                                    vertical: 15.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.80),
                                    Colors.white.withOpacity(0.20),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderGradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.60),
                                    Colors.white.withOpacity(0.10),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 1.0],
                                ),
                                blur: 400,
                                borderRadius: BorderRadius.circular(10.0),
                                elevation: 8.0,
                                shadowColor: Colors.black.withOpacity(0.40),
                                child: IconButton(
                                  splashRadius: 10.0,
                                  // borderRadius: BorderRadius.circular(10.0),
                                  icon: Icon(
                                    Icons.check,
                                    size: 30,
                                  ),
                                  onPressed: formattedDate == item['date']
                                      ? () {
                                          setState(() {
                                            Provider.of<Goals>(context,
                                                    listen: false)
                                                .changeComplete(item['id']);
                                            Provider.of<Goals>(context,
                                                    listen: false)
                                                .changePosition(
                                                    context, item['date'] - 1);
                                          });
                                        }
                                      : formattedDate == lastDate
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StaticsScreen(
                                                            isLastDate: true)),
                                              );
                                            }
                                          : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  .toList()
                  .reversed,
            ],
          ),
        ),
        floatingActionButton: Provider.of<Goals>(context).goals.any((item) {
          return item['date'] == formattedDate && item['completed'];
        })
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.red,
                    context: context,
                    builder: (BuildContext context) =>
                        MemoScreen(todayDate: formattedDate),
                  );
                },
                child: Icon(Icons.edit),
              )
            : null,
      ),
    );
  }
}
