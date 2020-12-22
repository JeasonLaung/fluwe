import 'dart:async';
import '../utils.dart';
import 'toast.dart';
export 'toast.dart' show ToastPosition;

/**
 * 暂时不用，推荐使用原生的fluttertoast
 */
/// 显示toast
// @deprecated
showFluweToast(msg, {ToastPosition position = ToastPosition.bottom}) {
  Function remove;
  remove = createOverlayEntry(
      hasWillPop: false, child: ToastWidget(msg, position: position));
  //两秒后，移除Toast
  Future.delayed(Duration(seconds: 2)).then((value) {
    remove();
  });
}
