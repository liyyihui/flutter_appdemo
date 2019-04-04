
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Ben/Project.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
 class ProjectState extends State<ProjectWidget> with AutomaticKeepAliveClientMixin{
   Project mdata;
   int next = 1;
   GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
   GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
   GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
   @override
  Widget build(BuildContext context) {
     super.build(context);
    return  Scaffold(

        body:EasyRefresh(
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
              Project  data = Project.fromJson(response.data);
              mdata.data.datas.addAll(data.data.datas);
              mdata.data.size = (mdata.data.size+data.data.size);
              setState(() {
                next = ++next;
              });
            },
            child:getBody()
        )
    );;
  }
  //初始化数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

   loadData() async {
     try {

       Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
       mdata = Project.fromJson(response.data);
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
    return ListView.builder(
          itemCount: mdata.data.size,
          itemBuilder: (BuildContext context, int position) {
            return  getItem( mdata,position);
          });

  } else {
   // 加载菊花
   return CupertinoActivityIndicator();
   }
 }

getItem(Project mdata, int position) {


  }

 }