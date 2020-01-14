import 'dart:async';
import '../utils.dart';
import 'toast.dart';
/**
 * 暂时不用，推荐使用原生的fluttertoast
 */
/// 显示toast
@deprecated showFluweToast(msg) {
  Function remove;
  remove = createOverlayEntry(
    hasWillPop: false,
    child: ToastWidget(msg)
  );
  //两秒后，移除Toast
  Future.delayed(Duration(seconds: 2)).then((value) {
    remove();
  });
}
