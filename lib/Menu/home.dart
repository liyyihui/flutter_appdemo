
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';

 class _MyHomeAppState extends State<MyAppHome>{
   @override
   void initState() {
     loadData();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(

       body: Center(
         child: getBody(),
       ),
     );
   }
 }
loadData() async {
  try {
    Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
    print(response);
    return response;

  } catch (e) {
    print(e);
    return null;
  }
}


getBody() {
  if (loadData().length != 0) {
    return ListView.builder(
        itemCount: loadData().length,
        itemBuilder: (BuildContext context, int position) {
          return getItem(loadData()[position]);
        });
  } else {
    // 加载菊花
    return CupertinoActivityIndicator();
  }
}

getItem(var subject) {

}

