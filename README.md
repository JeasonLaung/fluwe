# fluwe

A new Flutter package project.

## Getting Started

快速配置

```dart
main() async{
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