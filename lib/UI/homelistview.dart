import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app3/Ben/homeben.dart';
import 'package:flutter_app3/UI/HomeInfo.dart';
class HomelistView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomelistViewWidget();
  }

}

class HomelistViewWidget extends State<HomelistView>{
  HomeData mdata;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getBody();
  }
  ///初始化数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

   loadData() async {
    try {
      Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json");
      mdata = HomeData.fromJson(response.data);
      print("进来请求数据");
      setState(() {
        print("重新绘制");
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Widget getBody() {
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

  Widget getItem(HomeData mdata, int position) {
    GestureDetector(
      child:Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(mdata.data.datas[position].title),
          subtitle: Row(
            children: <Widget>[
              Text("作者:"+mdata.data.datas[position].author,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "分类:"+mdata.data.datas[position].superChapterName,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ) ,
      onTap: () => onitemidex(position),
    ) ;
  }

  onitemidex(int position) {

    Navigator.push(context, new MaterialPageRoute(builder: (context) => homeinfowidget( mdata.data.datas[position],false)),
    );
  }
}