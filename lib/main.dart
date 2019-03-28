import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'AppHttp/Mhttp.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override Widget build(BuildContext context) {
   return  new MaterialApp(
     title: "学习demo",
     theme: new ThemeData(
       primarySwatch: Colors.blue
     ),
     home: new MyAppHome(),
   );
  }


}

class MyAppHome extends StatefulWidget{
  MyAppHome({Key key, this.title}) : super(key: key);
  final String title;
    @override
   MyAppHomeState createState() => new MyAppHomeState();
}

class MyAppHomeState extends State<MyAppHome>  with SingleTickerProviderStateMixin{
  TextEditingController phoneController = new TextEditingController();
  TextEditingController phoneController2 = new TextEditingController();
  TabController tabController ;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        vsync: this,     //动画效果的异步处理，默认格式，背下来即可
        length: 7     //需要控制的Tab页数量

    );
    print("初始化");
   // geTestHttp();
  }

  @override
  void dispose() {
    tabController .dispose();
    super.dispose();
  }
  onPressSecondBtn(){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("点击了"),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text("玩Android"),
          bottom:  new TabBar(
            isScrollable: true,
            tabs:<Widget>[
              new Tab(text: "首页",
              ),
              new Tab(text: "项目"),
              new Tab(text: "体系"),
              new Tab(text: "公众号"),
              new Tab(text: "导航"),
              new Tab(text: "项目分类"),
              new Tab(text: "工具"),
            ],
            controller: tabController ,
          ),
        ),
        body: new TabBarView(
          controller: tabController,
            children:<Widget>[

              new ListView(
                children: <Widget>[
                  Text("项目"),
                ],
              ),
              new ListView(
                children: <Widget>[
                  Text("体系"),
                ],
              ),
              new ListView(
                children: <Widget>[
                  Text("公众号"),
                ],
              ),
              new ListView(
                children: <Widget>[
                  Text("导航"),
                ],
              ),
              new ListView(
                children: <Widget>[
                  Text("项目"),
                ],
              ),
              new ListView(
                children: <Widget>[
                  Text("工具"),
                ],
              ),
            ]
        )
    );

  }

  void _login() {
    print({'phone': phoneController.text, 'password': phoneController2.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('手机号码格式不对'),
          ));
    } else if (phoneController2.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('登录成功'),
          ));

      onTextClear();
    }
  }
  void onTextClear() {
    setState(() {
      phoneController.clear();
      phoneController2.clear();
    });
  }
}






