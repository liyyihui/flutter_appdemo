
import 'package:flutter/material.dart';
  ///项目页面
 class project extends  StatelessWidget{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProjectWidget();
  }
 }
 class ProjectWidget extends StatefulWidget{
   ProjectState  createState() => new ProjectState();
 }
 class ProjectState extends State<ProjectWidget>{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(

        body:Text("项目")
    );;
  }

 }