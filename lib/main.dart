import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Menu/MyAppHome.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override Widget build(BuildContext context) {
   return  new MaterialApp(
     title: "学习demo",
     theme: new ThemeData(
       primarySwatch: Colors.blue
     ),
     home: new MyAppHome(),
   );
  }

}






