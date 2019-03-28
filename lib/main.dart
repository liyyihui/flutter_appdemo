import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Menu/Setup.dart';
import 'package:flutter_app3/Menu/home.dart';
import 'package:flutter_app3/Menu/project.dart';
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
        length: 3     //需要控制的Tab页数量

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

            ],
            controller: tabController ,
          ),
        ),
        body: new TabBarView(
          controller: tabController,
            children:<Widget>[
              AppHome(),
              project(),
              SeTup(),
            ]
        )
    );

  }


  void onTextClear() {
    setState(() {
      phoneController.clear();
      phoneController2.clear();
    });
  }
}






