import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/goals.dart';

class MemoScreen extends StatefulWidget {
  final int todayDate;

  const MemoScreen({Key? key, required this.todayDate}) : super(key: key);

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    List<Map<String, dynamic>> goals =
        Provider.of<Goals>(context, listen: false).goals;
    Map<String, dynamic>? item = goals
        .firstWhere((map) => map['date'] == widget.todayDate, orElse: () => {});
    _textEditingController.text = item['memo'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              cursorColor: Colors.black45,
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'text...',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),

              ),
              maxLines:5,
              maxLength: 200,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    String memoText = _textEditingController.text; // 텍스트 필드의 값 가져오기
                    Provider.of<Goals>(context, listen: false)
                        .saveTodayMemo(memoText);
                    print('onPressed 안에 $memoText');
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16.0, color: Color(0xFFFFBDBD), fontFamily:'GmarketBold', ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose(); // 사용이 끝난 TextEditingController 해제
    super.dispose();
  }
}
