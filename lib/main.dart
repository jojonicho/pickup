import 'package:flutter/material.dart';
import 'package:scratch/screens/court_detail.dart';
import 'screens/home.dart';

void main() => runApp(App());

const HomeRoute = '/';
const CourtRoute = '/court_detail';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
      ),
      home: Home(),
    );
  }

  RouteFactory _routes() {
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
}
