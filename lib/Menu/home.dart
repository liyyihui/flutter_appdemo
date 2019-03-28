

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/HomeBen.dart';

   /// 主页
class AppHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeAppWidget();
  }
}
class HomeAppWidget extends StatefulWidget{
  _MyHomeAppState createState() => new _MyHomeAppState();
}

 class _MyHomeAppState extends State<HomeAppWidget>{
   @override
   void initState() {
     loadData();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(

       body:Text("首页")
     );
   }
 }
loadData() async {
  try {
    Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
    HomeData data =  response.data;
    print(data.data);
    return data;
  } catch (e) {
    print(e);
    return null;
  }
}


getBody() {
  print(loadData());
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

