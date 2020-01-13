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
            openSetting();
          },),
          WeCell('位置权限',onTap: () {
            requestPermission([PermissionGroup.locationAlways]).then((data) {
              showToast('获取成功');
            }).catchError((data) {
              showToast('获取失败');
            });
          },),
          WeCell('通讯录权限',onTap: () {
            requestPermission([PermissionGroup.contacts]).then((data) {
              showToast('获取成功');
            }).catchError((data) {
              showToast('获取失败');
            });
          },),
          WeCell('打开权限',onTap: () {
            openSetting();
          },)
        ]
      ),
    );
  }
}