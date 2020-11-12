import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import 'page/index/index_page.dart';
import 'routes/routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Fluwe.init(routesConfig: Routes.config);
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
        ));
  }
}
