import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app3/Ben/Tree.dart';
import 'package:flutter_app3/UI/TwoLevelList.dart';
 class SeTup extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _SetupWidget();
  }
 }

class _SetupWidget extends StatefulWidget {
  _SetupState createState() => new _SetupState();
}

class _SetupState extends State<_SetupWidget> with AutomaticKeepAliveClientMixin{
   Tree mdata;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Scaffold(

        body:homeview()
    );;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print("初始化体系数据");

  }

  loadData() async {
    try {
      Response response = await Dio().get("https://www.wanandroid.com/tree/json");
      mdata = Tree.fromJson(response.data);
      setState(() {
        print("重新绘制");
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  homeview() {

    if (mdata!=null&&mdata.data.length> 0) {
      return   TwoLevelList(mdata);
    } else {
      // 加载菊花
      return Text("无菜单数据");
    }
  }
}

