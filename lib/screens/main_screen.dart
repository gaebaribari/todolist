import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/memo_screen.dart';
import 'package:todolist/screens/statics_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<Goals>(context).goals;
    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.bar_chart_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StaticsScreen()));
              }),
        ],
      ),
      body: Stack(
        children:
            todoData.reversed.where((item) => !item['completed']).map((item) {
          return AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: item['topPosition'],
            left: item['sidePosition'],
            right: item['sidePosition'],
            child: Card(
              child: Container(
                height: 350,
                width: item['cardWidth'],
                child: Column(
                  children: [
                    Text(item['todo']),
                    Text(item['date'].toString()),
                    ElevatedButton(
                      onPressed: formattedDate == item['date']
                          ? () {
                              setState(() {
                                Provider.of<Goals>(context, listen: false)
                                    .changeComplete(item['id']);
                                Provider.of<Goals>(context, listen: false)
                                    .changeTopPosition(item['id']);
                              });
                            }
                          : null,
                      child: Text('완수'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: Provider.of<Goals>(context).goals.any((item) {
        return item['date'] == formattedDate && item['completed'];
      })
          ? FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) =>
                    MemoScreen(todayDate: formattedDate),
              ),
              child: Icon(Icons.edit_note_outlined),
            )
          : null,
    );
  }
}
