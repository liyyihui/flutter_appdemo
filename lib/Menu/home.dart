


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/homeben.dart';
import 'package:flutter_app3/UI/HomeInfo.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


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
   int next = 1;
   GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
   GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
   GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
   @override
   void initState() {
     loadData();

   }
   @override
   Widget build(BuildContext context) {
     mcontext = context;
     return Scaffold(
       body: new EasyRefresh(
         key: _easyRefreshKey,
         autoLoad: false,
         behavior: ScrollOverBehavior(),
         refreshHeader:ClassicsHeader(  //
           key: _headerKey,
           refreshText: "下拉刷新",
           refreshReadyText: "松开刷新",
           refreshingText: "刷新中...",
           refreshedText: "刷新完成",
           moreInfo: "刷新",
           bgColor: Colors.transparent,
           textColor: Colors.black87,
           moreInfoColor: Colors.black54,
           showMore: true,
         ),
         refreshFooter: ClassicsFooter(
           key: _footerKey,
           loadText: "上拉加载",
           loadReadyText:"松开加载",
           loadingText:"加载中。。。。",
           loadedText: "loaded",
           noMoreText: "加载完成",
           moreInfo: "加载",
           bgColor: Colors.transparent,
           textColor: Colors.black87,
           moreInfoColor: Colors.black54,
           showMore: true,
         ),
         onRefresh: () async{
              print("下啦刷新");
         },
         loadMore: () async {
           print("上拉加载");
           Response response = await Dio().get("https://www.wanandroid.com/article/list/"+next.toString()+"/json");
           HomeData data = HomeData.fromJson(response.data);
           mdata.data.datas.addAll(data.data.datas);
           mdata.data.size = (mdata.data.size+data.data.size);
           print("获得数据"+mdata.data.size.toString());
           print("数据长度"+mdata.data.size.toString());
           setState(() {
             print("加载绘制");
             next = ++next;
           });
         },
         child:getBody(mdata),
       )

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
               Text("作者:"+data.data.datas[index].author,
                 overflow: TextOverflow.ellipsis,
               ),
               Text(
                 "分类:"+data.data.datas[index].superChapterName,
                  overflow: TextOverflow.ellipsis,
               ),
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








