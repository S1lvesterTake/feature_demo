import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:my_flutter/app/misc/app_component.dart';
import 'package:my_flutter/app/misc/router.dart';
import 'package:my_flutter/app/pages/home_screen.dart';
// import 'package:my_flutter/app/pages/users/users_view.dart';
// import 'package:my_flutter/app/pages/video_player/video_player_view.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Router _router;

  MyApp() : _router = Router() {
    // _initLogger();

    // init dependency
    AppComponent.init();
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "My App",
      //home: UsersPage(),
      home: HomeScreen(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void _initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.info("Logger initialized.");
  }
}