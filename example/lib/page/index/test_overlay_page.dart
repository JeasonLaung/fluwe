// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import '../../widgets/widgets.dart';

/// 弹出层测试页面
class TestOverlayPage extends StatefulWidget {
  @override
  _TestOverlayPageState createState() => _TestOverlayPageState();
}

class _TestOverlayPageState extends State<TestOverlayPage> {
  List data = [];
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试弹出层'),
      ),
      body: SingleChildScrollView(
        child: WeCellGroup(
          children: <WeCell>[
            WeCell('modal', onTap: () {
              showModal(
                  title: '提示窗',
                  onCancel: () {
                    showToast('取消');
                  },
                  onConfirm: () {
                    showToast('确定');
                  });
            }),
            WeCell('toast原生的（推荐使用）', onTap: () {
              showToast('toast原生的');
            }),
            WeCell('toast弹出层的', onTap: () {
              showFluweToast('toast弹出层的');
            }),
            WeCell('等待', onTap: () {
              _timer?.cancel();
              showLoading(duration: Duration(seconds: 3));
              _timer = Timer(Duration(seconds: 2), () {
                closeLoading();
              });
            }),
            WeCell(
              '操作栏',
              onTap: () {
                showActionSheet(
                    itemList: [
                      {"title": '啊哈哈', "value": '456'},
                      {"title": 'aaaaa', "value": '123'},
                    ],
                    success: (val) {
                      showToast(val);
                    });
              },
            ),
            WeCell('previewImage', onTap: () {
              previewImage(
                  current:
                      'https://i0.hdslb.com/bfs/article/c220c9dd67c5df555cd8634abf0a06fd07ef1e44.jpg@1320w_882h.webp',
                  urls: [
                    'https://i0.hdslb.com/bfs/article/bac1333e15fda682caeb099cfde92e03495d0cfc.jpg@1320w_916h.webp',
                    'https://i0.hdslb.com/bfs/article/c220c9dd67c5df555cd8634abf0a06fd07ef1e44.jpg@1320w_882h.webp'
                  ]);
            }),
            WeCell('原生分享', onTap: () {
              share('check out my website https://example.com');
            }),
            WeCell('弹出全局context的', onTap: () {
              showDialog(
                  context: Fluwe.context,
                  // barrierDismissible: true,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Text("测试"),
                        ),
                      ],
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
