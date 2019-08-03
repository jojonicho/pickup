import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'widgets/widgets.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes(),
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
      ),
      home: Home(),
    );
  }
}
