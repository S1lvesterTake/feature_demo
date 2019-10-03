import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/app/pages/pages.dart';

class Router {
  RouteObserver<PageRoute> routeObserver;

  Router() {
    routeObserver = RouteObserver<PageRoute>();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.users:
        return _buildRoute(settings, new UsersPage());
      default:
        return null;
    }
  }
  
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}