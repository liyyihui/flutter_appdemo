

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Base/Utils.dart';
import 'package:flutter_app3/Ben/Collection.dart';
import 'package:flutter_app3/Ben/RetunInfo.dart';
import 'package:flutter_app3/Ben/homeben.dart';
import 'package:flutter_app3/UI/Btn.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class homeinfowidget extends StatefulWidget {
 var mhomedata;
   bool iscollect;
  homeinfowidget( this.mhomedata,this.iscollect, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeinfostate(mhomedata,iscollect);
  }




}

class homeinfostate extends State<homeinfowidget>{
  var mdata;
  bool iscollect;
  homeinfostate(  this.mdata ,this.iscollect,{Key key}) ;
  String mname,token_pass;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin  webviewPlugin = new  FlutterWebviewPlugin();
  // URL变化监听器
  StreamSubscription<String> onUrlChanged;

  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(mdata.title,overflow: TextOverflow.ellipsis),
        actions: <Widget>[

          mollectionbtnwidgit(
            click: iscollect,
            callback: (isok) => favoriteclick(isok),
          ),
        ],
      ),
      body:   new WebviewScaffold(
        url: mdata.link,
        withZoom: true,  // 允许网页缩放
        withLocalStorage: true, // 允许LocalStorage
        withJavascript: true, // 允许执行js代码
      )
    );
 }

  favoriteclick(bool isok) {
    print("点击收藏"+isok.toString());
    if(!isok){//收藏
      collect();
    }else{//取消收藏
      cancelcollect();
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<String> name = Utils.getloginname();
    Future<String> paw = Utils.getlogincookie();
    name.then((String mane){
      mname = mane;
    });
    paw.then((String coke){
      token_pass = coke;

    });
    webviewPlugin.close();
    onStateChanged  = webviewPlugin.onStateChanged.listen((WebViewStateChanged  state){
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
       switch(state.type){

       // 准备加载
         case WebViewState.shouldStart:

           break;
       // 开始加载
         case WebViewState.startLoad:

           break;

       // 加载完成
         case WebViewState.finishLoad:
           break;
         case WebViewState.abortLoad:

           break;

       }


    });


    print("路劲"+mdata.link);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("销毁");
    //onUrlChanged.cancel();
    onStateChanged.cancel();
    webviewPlugin.dispose();
    super.dispose();

  }
      ///收藏
   collect() async {
       print("收藏ID"+mdata.id.toString());
       Map<String, dynamic> headers = new Map();
       headers['Cookie'] ="loginUserName =" +mname+"; token_pass = "+token_pass;
       Options options = new Options(
           headers:headers
       );
     Response response = await Dio().post("https://www.wanandroid.com/lg/collect/"+mdata.id.toString()+"/json",options: options);
     print("返回结果"+response.toString());
       RetunInfo retunInfo =  RetunInfo.fromJson(response.data);
     if(retunInfo.errorCode == 0){ //成功
        Utils.toast("收藏成功");

     }else{ //失败
       Utils.toast("收藏失败");
     }
  }
    ///取消收藏
   cancelcollect() async {


     print("取消ID"+mdata.id.toString());
     Map<String, dynamic> headers = new Map();
     headers['Cookie'] ="loginUserName =" +mname+"; token_pass = "+token_pass;
     Options options = new Options(
         headers:headers
     );
     Response response = await Dio().post("https://www.wanandroid.com/lg/uncollect_originId/"+mdata.id.toString()+"/json",options: options);
     print("返回结果"+response.toString());
     RetunInfo retunInfo =  RetunInfo.fromJson(response.data);
     if(retunInfo.errorCode == 0){ //成功
       Utils.toast("取消成功");
     }else{ //失败
       Utils.toast("取消失败");
     }

   }
}