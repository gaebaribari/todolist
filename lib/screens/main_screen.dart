import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/statics_screen.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:todolist/widgets/check_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    Goals goalsProvider = context.watch<Goals>();
    List<Map<String, dynamic>> todoData = goalsProvider.goals;

    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));
    int lastDate = formattedDate + 7;


    Map<String, dynamic>? todayTodo = todoData.firstWhere(
          (element) =>
      element['date'] == formattedDate && !element['completed'],
      orElse: () => {},
    );

    if (todayTodo.isNotEmpty) {
      setState(() {
        _isButtonVisible = true;
      });
    } else {
      setState(() {
        _isButtonVisible = false;
      });
    }


    if (formattedDate > lastDate) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
              (StaticsScreen(
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
        body: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: _isButtonVisible ?
              Container(
                key: UniqueKey(),
                width: 400,
                height: 700,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      spreadRadius: 4,
                      offset: const Offset(1, 4),
                    )
                  ],
                ),
                child: GlassContainer(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  blur: 400,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
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
                      Text(
                        '${todayTodo['id']}일째',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ), //아니다 회색으로
                      Text('${todayTodo['todo']}'),
                      GlassContainer(
                        height: 70,
                        width: 400,
                        margin: EdgeInsets.symmetric(vertical: 15.0),
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
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              Provider.of<Goals>(context, listen: false)
                                  .changeComplete(todayTodo['id']);
                            });
                          },
                          child: Icon(
                            Icons.check,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ) : CheckContainer(),
            ),),
        ),
    );
  }

  }
