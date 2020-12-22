import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fluwe'),
      ),
      body: Container(
        width: rpx(750),
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('123'),
              onPressed: () {
                showModal();
              },
            ),
            RaisedButton(
              child: Text('123'),
              onPressed: () {
                closeModal();
              },
            ),
            RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                FluweRouter.navigateTo(page: IndexPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
