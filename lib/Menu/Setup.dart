import 'package:flutter/material.dart';
 class SeTup extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _SetupWidget();
  }
 }

class _SetupWidget extends StatefulWidget {
  _SetupState createState() => new _SetupState();
}

class _SetupState extends State<_SetupWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(

        body:Text("体系")
    );;
  }
}