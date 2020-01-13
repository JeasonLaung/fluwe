import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import '../../widgets/widgets.dart';
/// 弹出层测试页面
class TestLaunchPage extends StatefulWidget {
  @override
  _TestLaunchPageState createState() => _TestLaunchPageState();
}

class _TestLaunchPageState extends State<TestLaunchPage> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('唤起应用'),),
      body: WeCellGroup(
        children: [
          WeCell('打开网页',
            onTap: () {
              openBrower(url: 'https://baidu.com');
          }),
          WeCell('微信',
            onTap: () {
              openApp(appName: OpenAppType.weixin);
          }),
          WeCell('支付宝',
            onTap: () {
              openApp(appName: OpenAppType.alipays);
          }),
          WeCell('打电话',
            onTap: () {
              makePhoneCall(phoneNumber: '1868026300');
          }),
          WeCell('发邮件',
            onTap: () {
              sendMail(email: '1868026300', body: '我草');
          }),
          WeCell('发短信',
            onTap: () {
              sendMessage(phoneNumber: '1868026300');
          }),
        ],
      ),
    );
  }
}