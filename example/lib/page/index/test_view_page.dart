import 'package:flutter/material.dart';

import 'package:fluwe/fluwe.dart';

/// 路由测试页面
class TestViewPage extends StatefulWidget {
  @override
  _TestViewPageState createState() => _TestViewPageState();
}

class _TestViewPageState extends State<TestViewPage> {
  @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('布局'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  width: vw(50),
                  height: px(100),
                  child: Text('50vw'),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  width: vw(20),
                  child: Text('20vw'),
                  height: px(100),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.redAccent,
                  width: vw(30),
                  child: Text('30vw'),
                  height: px(100),
                ),
              ],
            ),


            SizedBox(height: 30),

            Container(
              height: px(100),
              width: vw(100),
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: Text('100vw'),
            ),

            SizedBox(height: 30),

            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  width: px(200),
                  height: px(100),
                  child: Text('200px'),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  width: px(100),
                  height: px(100),
                  child: Text('100px'),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.redAccent,
                  width: px(450),
                  child: Text('450px'),
                  height: px(100),
                ),
              ],
            ),


            SizedBox(height: 30),

            Container(
              alignment: Alignment.center,
              color: Colors.blueAccent,
              width: px(750),
              child: Text('750px'),
              height: px(100),
            ),

            SizedBox(height: 30),

            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  width: px(100),
                  height: vh(10),
                  child: Text('10vh'),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  width: px(100),
                  height: vh(30),
                  child: Text('30vh'),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}