

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class homeinfo extends StatelessWidget{
  String url;
  String title;
  homeinfo({Key key, @required this.url,this.title
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(title,overflow: TextOverflow.ellipsis,)
      ),
      body: homeinfowidget(url:url),
    );
  }
}

class homeinfowidget extends StatefulWidget {
  String url;
  homeinfowidget({Key key, @required this.url}) : super(key: key);
  homeinfostate createState ()=> homeinfostate(url: url);
}

class homeinfostate extends State<homeinfowidget>{

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin  webviewPlugin = new  FlutterWebviewPlugin();
  // URL变化监听器
  StreamSubscription<String> onUrlChanged;

  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;
  String url;
  homeinfostate({Key key, @required this.url});
 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
        url: "www.baidu.com",
      withZoom: true,  // 允许网页缩放
      withLocalStorage: true, // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewPlugin.close();
    onStateChanged  = webviewPlugin.onStateChanged.listen((WebViewStateChanged  state){
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
        print(state.type);
    });


    print("路劲"+url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    onUrlChanged.cancel();
    onStateChanged.cancel();
    webviewPlugin.dispose();
    super.dispose();

  }
}