import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app3/Ben/artice.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
class articlelistview extends StatefulWidget{
  int id;
  articlelistview(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return articleliststate(id);
  }
}

class articleliststate extends State<articlelistview>{
  int id,next = 1;
  artice mdata;

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  articleliststate(this.id):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title: Text("体系"),
      ),
      body: EasyRefresh(
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
            Response response = await Dio().get("https://www.wanandroid.com/article/list/"+next.toString()+"/json?cid="+id.toString());
            artice data = artice.fromJson(response.data);
            mdata.data.datas.addAll(data.data.datas);
            mdata.data.size = (mdata.data.size+data.data.size);
            setState(() {
              next = ++next;
            });
          },
          child:getbody()
      ),
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

   loadData() async {

     try {

       Response response = await Dio().get("https://www.wanandroid.com/article/list/0/json?cid="+id.toString());
       mdata = artice.fromJson(response.data);
       setState(() {
         print("重新绘制");
       });
     } catch (e) {
       print(e);
       return null;
     }
  }

  getbody() {

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

    getItem(artice data,int index) {
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
                  "  分类:"+data.data.datas[index].chapterName,
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
  }

}