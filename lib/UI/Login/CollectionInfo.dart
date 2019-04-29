import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Base/Utils.dart';
import 'package:flutter_app3/Ben/Collection.dart';
import 'package:flutter_app3/UI/HomeInfo.dart';
class CollectionInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CollectionState();
  }

}

class CollectionState  extends State<CollectionInfo>{
  Collection mdata;
  String mname,token_pass;
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
      _getmydata();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏博文"),
        centerTitle: true,
      ),
      body: _getlayout(),
    );
  }

  _getlayout() {
    print("进来了");
    if (mdata!=null&&mdata.data.datas.length > 0) {

      return
        ListView.builder(
            itemCount: mdata.data.datas.length,
            itemBuilder: (BuildContext context, int position) {
              return  getItem( mdata,position);
            });
    } else {
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }

  _getmydata() async{
    try {




      Map<String, dynamic> headers = new Map();
      headers['Cookie'] ="loginUserName =" +mname+"; token_pass = "+token_pass;
      Options options = new Options(
          headers:headers
      );

      Response response1 = await Dio().get("https://www.wanandroid.com/lg/collect/list/0/json",options: options);

      mdata = Collection.fromJson(response1.data);

      setState(() {
        print("重新绘制");
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Widget getItem(Collection mdata, int position) {
   return GestureDetector(
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
                "分类:"+mdata.data.datas[position].chapterName,
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

    print("点击"+position.toString());
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new homeinfo( url :mdata.data.datas[position].link,title:mdata.data.datas[position].title)),
    );
  }
}