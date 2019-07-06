import 'package:flutter/material.dart';
import 'UI/pages/Home.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'locator.dart';

void main() {
  timeDilation = 2;
  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Grocery Store',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'JosefinSans',
      ),
      home: MyHomePage(),
    );
  }
}
