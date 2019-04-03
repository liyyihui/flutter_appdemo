


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/bannerdata.dart';
import 'package:flutter_app3/Ben/homeben.dart';
import 'package:flutter_app3/UI/Banner/bannerview.dart';
import 'package:flutter_app3/UI/HomeInfo.dart';
import 'package:flutter_app3/UI/homelistview.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


   /// 主页
class AppHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeAppWidget();
  }
}
class HomeAppWidget extends StatefulWidget {
  _MyHomeAppState createState() => new _MyHomeAppState();
}

 class _MyHomeAppState extends State<HomeAppWidget> with AutomaticKeepAliveClientMixin{
   HomeData mdata;
   List<String> url = new List();
   int next = 1;
   GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
   GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
   GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
   SwiperController _swiperController;
   BannerImage mImagedata;

   @override
   void initState() {
    getbannder();
     _swiperController = new SwiperController();
     loadData();

   }
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }
   @override
   Widget build(BuildContext context) {

     return Scaffold(

                   body: Column(
                     children: <Widget>[
                         Container(
                           height: 170,
                             child: Swiper(
                               itemCount: url.length,
                               itemBuilder: (BuildContext context,int index ){
                                 return Image.network(url[index],fit: BoxFit.fill,);
                               },
                               autoplay: true,//自动循环
                               pagination: SwiperPagination(),
                               controller: _swiperController,
                               onTap: (index)=>banneritemclick(index),
                             ),
                         ),

                        //getBody()
                       Expanded(

                         child:new EasyRefresh(
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
             Response response = await Dio().get("https://www.wanandroid.com/article/list/"+next.toString()+"/json");
             HomeData data = HomeData.fromJson(response.data);
             mdata.data.datas.addAll(data.data.datas);
             mdata.data.size = (mdata.data.size+data.data.size);
             setState(() {
               next = ++next;
             });
           },
           child:getBody()

         ),

                       )
                     ],
                   ),


      );
   }

   loadData() async {
     try {

       Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
       mdata = HomeData.fromJson(response.data);
      setState(() {
         print("重新绘制");
      });
     } catch (e) {
       print(e);
       return null;
     }
   }



   getBody() {
     if (mdata!=null&&mdata.data.size > 0) {
       return
             ListView.builder(
             itemCount: mdata.data.size,
             itemBuilder: (BuildContext context, int position) {
               return  getItem( mdata,position);
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
                 "  分类:"+data.data.datas[index].superChapterName,
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
     Navigator.push(context, new MaterialPageRoute(
         builder: (context) => new homeinfo(
             url :mdata.data.datas[index].link,
             title:mdata.data.datas[index].title)),
     );
   }


   ///获取banner 图片资源
   getbannder() async {
    Response response = await Dio().get("http://www.wanandroid.com/banner/json/");
     mImagedata = BannerImage.fromJson(response.data);
    for( int i= 0;i<mImagedata.data.length;i++){
    url.add(mImagedata.data[i].imagePath);

    }
    setState(() {
      print("重新绘制图片");
    });


  }

  banneritemclick(index) {

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) => new homeinfo(
            url :mImagedata.data[index].url,
            title:mImagedata.data[index].title)),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
 }








