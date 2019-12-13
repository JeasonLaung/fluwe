import 'dart:async';
import '../utils.dart';
import 'loading.dart';
/// 打开loading弹出层
Future showLoading({
  String msg, 
  Duration duration,
  /// 取消加载
  Function onCancel, 
  /// 可以返回
  canBack = true}) async{

  /// 已经返回
  bool backed = false;
  createOverlayEntry(
    willPopCallback: () async{
      if (canBack && backed == false) {
        backed = true;
        if (onCancel is Function) {
          await onCancel();
        }
        return true;
      } else {
        return false;
      }
    },
    child: LoadingWidget()
  );

  if(duration is Duration) {
    Timer(duration, () {
      if (backed == false) {
        closeLoading();
      }
    });
  }
}


/// 关闭loading弹出层
Future closeLoading() async{
  Router.navigateBack();
}

