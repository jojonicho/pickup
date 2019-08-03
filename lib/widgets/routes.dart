import 'package:flutter/material.dart';
import 'package:scratch/screens/court_detail.dart';
import '../screens/home.dart';

const HomeRoute = '/';
const CourtRoute = '/court_detail';

RouteFactory routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case HomeRoute:
        screen = Home();
        break;
      case CourtRoute:
        screen = CourtDetail(arguments['id']);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
