import 'package:flutter/material.dart';
import 'package:animated_page_transition/animated_page_transition.dart';


class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  @override
  Widget build(BuildContext context) {
    return PageTransitionReceiver(
      scaffold: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.greenAccent,
        ),
        body: Text('메모페이지입니다'),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
