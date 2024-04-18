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

    List<Map<String, dynamic>> beforeToday = [
      ...todoData.where((item) => item['date'] < formattedDate).toList()
        ..sort((a, b) => b['date'].compareTo(a['date']))
    ];

    List<Map<String, dynamic>> afterToday = [
      ...todoData
          .where((item) => item['date'] >= formattedDate && !item['completed'])
          .toList()
        ..sort((a, b) => b['date'].compareTo(a['date']))
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StaticsScreen(isLastDate: false)));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ...beforeToday.map((item) {
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
                                      .changeTopPosition(item['date']);
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
          ...afterToday.map((item) {
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
                            : formattedDate == lastDate
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StaticsScreen(isLastDate: true)),
                                    );
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
        ],
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
