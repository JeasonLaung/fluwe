


import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RaisedButton(
              child: Text('弹出'),
              onPressed: () {
                showToast('哈哈哈哈');
              },
            ),

            RaisedButton(
              child: Text('弹出Modal'),
              onPressed: () {
                showModal(
                  title: '弹窗',
                  content: 'hallo',
                  onCancel: () {
                    showToast('你点了取消');
                  },
                  onConfirm: () {
                    showToast('你点了确定');
                  }
                );
              },
            ),
            RaisedButton(
              child: Text('分享'),
              onPressed: () {
                share('https://baidu.com',);
              },
            ),
          ]
        )
      )
      
    );
  }
}

