import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import '../../widgets/widgets.dart';

/// 路由测试页面
class TestRouterPage extends StatefulWidget {
  final int pageCount;
  TestRouterPage({this.pageCount = 0});
  @override
  _TestRouterPageState createState() => _TestRouterPageState();
}

class _TestRouterPageState extends State<TestRouterPage> {
  @override
  void initState() {
    super.initState();
    showToast('页面打开时携带参数为pageCount:${widget.pageCount}');
  }

  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('测试路由${widget.pageCount}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              WeCellGroup(
                children: <WeCell>[
                  WeCell(
                    '测试跳转',
                    onTap: () {
                      FluweRouter.navigateTo(
                          page: TestRouterPage(
                        pageCount: widget.pageCount + 1,
                      )).then((val) {
                        /// 从前一个页面返回的值输出
                        showToast('$val \n 当前页面为第${widget.pageCount}页');
                      });
                    },
                  ),
                  WeCell('测试返回1层', onTap: () {
                    FluweRouter.navigateBack(
                        delta: 1, result: '我从${widget.pageCount}页面返回过来的');
                  }),
                  WeCell('测试返回3层', onTap: () {
                    FluweRouter.navigateBack(
                        delta: 3, result: '我从${widget.pageCount}页面返回过来的');
                  }),
                ],
              ),
              WeCellGroup(
                title: 'url模式（可带参数）',
                children: <WeCell>[
                  WeCell(
                    '用url模式跳转带参数的一页',
                    onTap: () {
                      FluweRouter.navigateTo(
                          url: '/test_router',
                          params: {'id': widget.pageCount + 1}).then((val) {
                        /// 从前一个页面返回的值输出
                        showToast('$val \n 当前页面为第${widget.pageCount}页');
                      });
                    },
                  ),
                  WeCell(
                    '用url模式重定向一个页面',
                    onTap: () {
                      FluweRouter.redirect(
                          url: '/test_router',
                          params: {'id': widget.pageCount + 1}).then((val) {
                        /// 从前一个页面返回的值输出
                        showToast('$val \n 当前页面为第${widget.pageCount}页');
                      });
                    },
                  ),
                  WeCell(
                    '全部页面关闭并打开一个页面',
                    onTap: () {
                      FluweRouter.reLaunch(
                          url: '/test_router',
                          params: {'id': widget.pageCount + 1}).then((val) {
                        /// 从前一个页面返回的值输出
                        showToast('$val \n 当前页面为第${widget.pageCount}页');
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
