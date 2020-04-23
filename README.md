
# 快速使用
`框架懒人命令` `main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import 'routes/routes.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Fluwe.init(
    routesConfig: Routes.config
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Router.navigatorKey,
      onGenerateRoute: Router.onGenerateRoute,
      home: FluweApp(
        child: IndexPage(),
      )
    );
  }
}
```
路由快速配置 `/routes/routes.dart`
```dart
import 'package:fluwe/fluwe.dart';

import '../page/index/test_file_page.dart';
import '../page/index/test_router_page.dart';
class Routes {
  static List<RouteOptions> config = [
    RouteOptions(
      url: '/test_router',
      page: (args) {
        int id = args['id'];
        return TestRouterPage(
          pageCount: id
        );
      }
    ),
    RouteOptions(
      url: '/test_file',
      page: (args) {
        return TestFilePage(
        );
      }
    )
  ];
}
```


# 配置环境
### flutter_downloader
https://github.com/fluttercommunity/flutter_downloader



# 框架手册

源码地址：[https://github.com/JeasonLaung/fluwe](https://github.com/JeasonLaung/fluwe)

### 如果您喜欢我的框架请给我star走一波，谢谢各位！

# fluwe（欢迎指点）

一个flutter项目快捷template，包含websocket，dio，bloc，fluro，微信小程序api，推送等方便前端开发者快速上手flutter开发APP的应用



# 参考ui框架
+ 特别感谢这个weui框架，学习写ui框架的可以参考一下这个git，一句牛逼送给你

https://github.com/allan-hx/flutter-weui



# 模块

+ 请求模块[dio](https://pub.flutter-io.cn/packages/dio)


+ 路由，自制，比fluro更好用更方便的，你用过不好用的话我切鸡鸡

## 请求篇API
### `所有请求函数不建议放在助手函数中使用`
```Router.navigateBack```


## 路由篇API
### `所有路由函数不建议放在助手函数中使用`
```Router.navigateBack```
``` dart
 /// 返回两页
 Router.navigateBack(
     /// 返回页数
   delta: 2,
   /// 发送到该页面的参数
   result: '12345689'
);
```

```Router.navigateTo```

``` dart
   /// 跳转页面
   Router.navigateTo(
     page: HomePage(
       id: '123456'
     ),
   );
   
   /// 或
  
   Router.navigateTo(
     url: '/login',
     agruments: {
       'uid': '123465'
     },
   );
 
  ```

```Router.redirect```

``` dart
    /// 重定向页面`
    Router.redirect(
        page: HomePage(
        id: '123456'

    );
```



```Router.reLaunch```

``` dart
    /// 重重载页面`
    Router.reLaunch(
        page: HomePage(
        id: '123456'

    );
```



## 助手api一览

+ 原生分享previewImage
```previewImage```

eg： 
```dart 
previewImage(
  current: 'https://i0.hdslb.com/bfs/article/c08ee42f2e8a2c76d9b7e1e18e4d1b7a738f2ced.jpg@1320w_990h.webp',
  urls: [
    'https://i0.hdslb.com/bfs/article/c08ee42f2e8a2c76d9b7e1e18e4d1b7a738f2ced.jpg@1320w_990h.webp',
    'https://i0.hdslb.com/bfs/article/a493bfd308cd50c3e8cc0f7d56334f3b2e3bc3b5.jpg@1320w_882h.webp'
  ]
);
```

+ 原生分享share
```share```

eg： 
```dart 
share('桃乃木真好看');
```

+ 原生弹出toast
```showToast```

eg： 
```dart 
showToast('哈哈哈');
```

+ 加载弹出层
```showLoading```

eg： 
```dart 
showLoading(title: '哈哈哈');
```

+ modal弹出层
```showModal```

eg： 
```dart 
showModal(title: '弹出窗');
```

+ 打电话
```makePhoneCall```

eg： 
``` dart
makePhoneCall(phoneNumber： '18888888888');
```

+ 发短信
```sendMessage```

eg： 
``` dart
sendMessage(phoneNumber： '18888888888');
```


+ 打开应用
```openApp```

eg：
``` dart
openApp(appName: OpenAppType.alipays);
```

+ 打开应用
```openBrower```

eg： 
``` dart
openBrower(url 'https://www.baidu.com');
```

+ 选择图片
```chooseImage```

eg： 
``` dart
chooseImage();
```




+ 像素
```px```

eg： 
``` dart
px(50)
```

+ 仿微信小程序像素
```rpx```

eg： 
```dart
rpx(50)
```

+ 宽百分比
```vw```

eg： 
``` dart
vw(50)
```

+ 高百分比
```vh```

eg： 
```dart
vw(50)
```


