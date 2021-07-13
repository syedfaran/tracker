import 'package:flutter/material.dart';
import 'package:flutter_app/helper/theme/app_theme.dart';
import 'package:flutter_app/route_generator.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [
        RouteObservers.routeObserver,
      ],
    );
  }
}
