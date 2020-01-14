import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import './pages/index_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Fluwe.init(
    routesConfig: [],
    
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
        child: IndexPage()
      )
    );
  }
}

