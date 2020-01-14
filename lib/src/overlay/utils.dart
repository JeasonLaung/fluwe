import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../router/router.dart';
export '../router/router.dart';
BuildContext  get overlayCurrentContext {
  return Router.navigatorKey.currentContext;
}

NavigatorState  get overlayCurrentState {
  return Router.navigatorKey.currentState;
}

OverlayState get overlayCurrent {
  return Router.navigatorKey.currentState.overlay;
}


/// ----------------------
/// 
/// overlay状态器，专门中来关闭overlay弹出层的
/// 结合路由和overlay，不过路由的弹出层一定有问题，一定一定会改的，但现在是找不到
/// 
/// ----------------------

class OverlayStateStates{
  static bool lock = true;
}



typedef WillPopCallbackFromOverlay = Future<bool> Function();
/// 创建OverlayEntry
createOverlayEntry({
  @required Widget child,
  bool hasWillPop = true,
  WillPopCallbackFromOverlay willPopCallback,
  Duration transitionDuration,
  RouteTransitionsBuilder transitionBuilder,
  Color backgroundColor = const Color(0x80000000)
}) {
  OverlayEntry overlayEntry;

  if (hasWillPop == false) {
    overlayEntry = new OverlayEntry(builder: (context) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.body1,
        child: child
      );
    });
    overlayCurrent.insert(overlayEntry);

    void close() {
      overlayEntry.remove();
    }
    return close;
  } else{
    overlayCurrentState.push(FluweDialogRoute(
      barrierColor: backgroundColor,
      pageBuilder: (context, animation1, animation2) {
        return WillPopScope(
          child: DefaultTextStyle(
            child: child,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              color: Colors.black
            )
          ),
          onWillPop: willPopCallback ?? () async=> true,
        );
      }
    )).then((val) {
      /// 互锁
      OverlayStateStates.lock = false;
    });
  }
}

///
/// 一个route路由
///
class FluweDialogRoute<T> extends PopupRoute<T> {
  FluweDialogRoute({
    @required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder transitionBuilder,
    RouteSettings settings,
  }) : assert(barrierDismissible != null),
       _pageBuilder = pageBuilder,
       _barrierDismissible = barrierDismissible,
       _barrierLabel = barrierLabel,
       _barrierColor = barrierColor,
       _transitionDuration = transitionDuration,
       _transitionBuilder = transitionBuilder,
       super(settings: settings);
  
  final RoutePageBuilder _pageBuilder;
  
  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;


  final RouteTransitionsBuilder _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}

