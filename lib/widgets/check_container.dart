import 'package:flutter/material.dart';
import 'package:todolist/screens/memo_screen.dart';
import 'package:intl/intl.dart';


class CheckContainer extends StatelessWidget {
  const CheckContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    int formattedDate = int.parse(DateFormat('yyMMdd').format(now));

    return Container( // 콜론(:)이 누락되었습니다.
      key: UniqueKey(),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.red,
            context: context,
            builder: (BuildContext context) =>
                MemoScreen(todayDate: formattedDate),
          );
        },
      ),
    );
  }
}
