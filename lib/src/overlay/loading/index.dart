import 'dart:async';
import '../../common/fluwe.dart';

import '../utils.dart';
import 'loading.dart';
/// 打开loading弹出层
Timer _timer;
Future showLoading({
  String msg, 
  Duration duration,
  /// 取消加载
  Function onCancel, 
  /// 可以返回
  canBack = true}) async{
  _timer?.cancel();
  Fluwe.isLoading = true;
  createOverlayEntry(
    willPopCallback: () async{
      if (onCancel is Function) {
        onCancel();
      }
      if(canBack == false) {
        return false;
      } else {
        Fluwe.isLoading = false;
        return true;
      }
      
    },
    child: LoadingWidget()
  );
  if(duration is Duration) {
    _timer = Timer(duration, () {
      if (Fluwe.isLoading) {
        closeLoading();
      }
    });
  }
}


/// 关闭loading弹出层
Future closeLoading() async{
  Router.navigateBack(isLoading: true);
}

