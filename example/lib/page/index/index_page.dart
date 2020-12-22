import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import '../../widgets/widgets.dart';
import 'test_file_page.dart';
import 'test_overlay_page.dart';
import 'test_router_page.dart';
import 'test_view_page.dart';
import 'test_auth_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Scrollbar(
              child: SingleChildScrollView(
                  child: Column(children: [
        SizedBox(
          height: 70.0,
        ),
        Text(
          'Fluwe',
          style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
        WeCellGroup(
          children: <WeCell>[
            // Text('版本号：' + Application.version),
            // Text('软件名：' + Application.appName),
            // Text('打包次数：' + Application.buildNumber),
            // Text('包名：' + Application.packageName),
            WeCell(
              '无context路由',
              onTap: () {
                FluweRouter.navigateTo(page: TestRouterPage());
              },
            ),
            WeCell(
              '无context弹出层',
              onTap: () {
                FluweRouter.navigateTo(page: TestOverlayPage());
              },
            ),
            WeCell(
              '文件操作页面',
              onTap: () {
                FluweRouter.navigateTo(page: TestFilePage());
              },
            ),
            WeCell(
              '布局',
              onTap: () {
                FluweRouter.navigateTo(page: TestViewPage());
              },
            ),
            WeCell(
              '权限',
              onTap: () {
                FluweRouter.navigateTo(page: TestAuthPage());
              },
            ),
          ],
        ),
      ])))),
    );
  }
}
