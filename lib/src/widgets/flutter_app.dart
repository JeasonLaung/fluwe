import 'package:flutter/material.dart';
import '../common/fluwe.dart';

class FluweApp extends StatelessWidget {
  final Widget child;
  FluweApp({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (Fluwe.mediaQueryData == null) {
          MediaQueryData _queryData = MediaQuery.of(context);
          Fluwe.mediaQueryData = _queryData;
          Fluwe.statusBarHeight = _queryData.padding.top;
          Fluwe.screenHeight = _queryData.size.height;
          Fluwe.screenWidth = _queryData.size.width;
        }
        return child;
      }
    );
  }
}
