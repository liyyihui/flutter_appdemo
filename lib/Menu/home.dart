

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/homeben.dart';

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
       body:  getBody(mdata),
     );
   }


 }
HomeData mdata;
loadData() async {
  try {
    Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
    mdata = HomeData.fromJson(response.data);

   print("获得数据"+mdata.data.size.toString());
  } catch (e) {
    print(e);
    return null;
  }
}


getBody(HomeData mdata) {

  if (mdata.data.size > 0) {
    return ListView.builder(
        itemCount: mdata.data.size,
        itemBuilder: (BuildContext context, int position) {
          return getItem( mdata,position);
        });
  } else {
    // 加载菊花
    return CupertinoActivityIndicator();
  }
}

getItem(HomeData data,int index) {
  return Text(data.data.datas[index].title);
}

