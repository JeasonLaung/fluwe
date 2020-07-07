import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';

class TextAuthPage extends StatefulWidget {
  @override
  _TextAuthPageState createState() => _TextAuthPageState();
}

class _TextAuthPageState extends State<TextAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

class TestAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('权限'),),
      body: WeCellGroup(
        children: <WeCell>[
          WeCell('打开权限',onTap: () {
            // openSetting();
          },)
        ]
      ),
    );
  }
}