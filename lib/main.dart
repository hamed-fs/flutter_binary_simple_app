import 'package:flutter/material.dart';

import 'package:flutter_binary_simple_app/pages/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Binary Sample',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}
