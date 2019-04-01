


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/homeben.dart';
import 'package:flutter_app3/UI/HomeInfo.dart';


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
   HomeData mdata;
   BuildContext mcontext;
   @override
   void initState() {
     loadData();

   }
   @override
   Widget build(BuildContext context) {
     mcontext = context;
     return Scaffold(
       body: Card(
         color: Colors.white,
         elevation: 4.0,
         child: getBody(mdata),
         ),

     );
   }

   loadData() async {
     try {
       Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
       mdata = HomeData.fromJson(response.data);
       print("获得数据"+mdata.data.size.toString());
      setState(() {
         print("重新绘制");
      });
     } catch (e) {
       print(e);
       return null;
     }
   }


   getBody(HomeData mdata) {

     if (mdata!=null&&mdata.data.size > 0) {
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
     return GestureDetector(
       child:Card(
         elevation: 5.0,
         child: ListTile(
           title: Text(data.data.datas[index].title),
           subtitle: Row(
             children: <Widget>[
               Text("作者:"+data.data.datas[index].author),
               Text("分类:"+data.data.datas[index].superChapterName),
             ],
           ),
           trailing: Icon(Icons.keyboard_arrow_right),
         ),
       ) ,
       onTap: () => onitemidex(index),
     ) ;
   }

   onitemidex(int index) {
     print("点击"+index.toString());
     Navigator.push(context, new MaterialPageRoute(builder: (context) => new homeinfo( url :mdata.data.datas[index].link,title:mdata.data.datas[index].title)),
     );
   }
 }








