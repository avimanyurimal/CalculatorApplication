import 'package:flutter/material.dart';
import 'appwithcalculator.dart';
import 'calculator.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/appwithcalculator',// for initial page
      home: appwithcalculator(),
      routes: {
        '/appwithcalculator': (context) => appwithcalculator(),
        '/login_page': (context) => login_page(),
        '/Calculator': (context) => calculator(),
      },
    );
  }
}
