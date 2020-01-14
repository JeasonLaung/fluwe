import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import '../options/options.dart';
import '../common/fluwe.dart';



/// -----------------------------
/// 
///  路由管理器
/// 
/// -----------------------------

// 用法
// Router



///
/// 路由跳转方式
///
enum RouterType {
  /// 关闭所有打开一个页面
  reLaunch,
  /// 重定向一个页面
  redirect,
  /// 添加一个页面
  navigateTo
}


///
/// 路由操作
/// 
class Router {
  /// 导航器全局key
  static GlobalKey<NavigatorState> navigatorKey;

  static List<RouteOptions> configs;

  static void config(List<RouteOptions> cf) {
    configs = cf;
  }

  /// 路由阻断器
  static Route<dynamic> onGenerateRoute (RouteSettings routeSettings) {
    /// 路由名称
    String url = routeSettings.name;
    /// 路由参数
    Object args = routeSettings.arguments ?? const {};
    for (var i = 0; i < configs.length; i++) {
      if(configs[i].url == url) {
        return createRoute(configs[i].page(args));
      }
    }
    showToast('找不到路由');
    return null;
  }

  /// 当前路由，这个十分重要
  static Route currentRoute;

  /// `各种路由操作`
  /// ```
  /// Router.navigateBack(
  ///   delta: 2,
  ///   result: '12345689'
  /// );
  /// ```
  static Future navigateBack({int delta: 1, result, isLoading = false}) async{
    /// loading表示
    if(isLoading == true && Fluwe.isLoading == false) {
      return false;
    }
    /// 循环delta次返回
    for (var i = 0; i < delta; i++) {
      if(navigatorKey.currentState.canPop()) {
        navigatorKey.currentState.pop(delta == i + 1 ? result : null);
      }
    }
    /// loading表示
    Fluwe.isLoading = false;
    return true;
  }

  /// `跳转页面`
  /// ```
  /// Router.navigateTo(
  ///   page: HomePage(
  ///     id: '123456'
  ///   ),
  /// );
  /// ```
  /// 
  /// 或
  /// 
  /// ```
  /// Router.navigateTo(
  ///   url: '/login',
  ///   agruments: {
  ///     'uid': '123465'
  ///   },
  /// );
  /// ```
  static Future navigateTo({Widget page, RouterType type = RouterType.navigateTo, String url, Object params = const {}}) async{
    /// loading表示(防止loading乱占用导航问题关闭他)
    await navigateBack(isLoading: true);

    if(page != null) {
      Route pushPage = createRoute(page);

      /// 记录为当前路由
      currentRoute = pushPage;

      switch (type) {
        case RouterType.navigateTo:
          return await navigatorKey.currentState.push(pushPage);
        case RouterType.redirect:
          return await navigatorKey.currentState.pushReplacement(pushPage);
        case RouterType.reLaunch:
          return await navigatorKey.currentState.pushAndRemoveUntil(pushPage, (Route<dynamic> route) => false);
        default:
          return false;
      }
      
    } else if (url!=null) {
      switch (type) {
        case RouterType.navigateTo:
          return await navigatorKey.currentState.pushNamed(url, arguments: params);
        case RouterType.redirect:
          return await navigatorKey.currentState.pushReplacementNamed(url, arguments: params);
        case RouterType.reLaunch:
          return await navigatorKey.currentState.pushNamedAndRemoveUntil(url, (Route<dynamic> route) => false, arguments: params);
        default:
          return false;
      }
    }
    
  }

  /// `重载页面`
  /// ```
  /// Router.reLaunch(
  ///   page: HomePage(
  ///     id: '123456'
  ///   ),
  /// );
  /// ```
  /// 全部路由删掉并打开一个页面
  static Future reLaunch({Widget page, String url, Object params}) async{
    navigateTo(page: page, type: RouterType.reLaunch, url: url, params: params);
  }

  /// `重载页面`
  /// ```
  /// Router.redirect(
  ///   page: HomePage(
  ///     id: '123456'
  ///   ),
  /// );
  /// ```
  /// 重定向一个页面
  static Future redirect({Widget page, String url,Object params}) async{
    navigateTo(page:page, type: RouterType.redirect, url: url, params: params);
  }




  /// `创建一个平移变换`
  /// 跳转过去查看源代码，可以看到有各种各样定义好的变换
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }


  /// 创建一个route
  static Route createRoute(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation) {
          return page;
        }, transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          // 添加一个平移动画
          return createTransition(animation, child);
        }
    );
  }
}