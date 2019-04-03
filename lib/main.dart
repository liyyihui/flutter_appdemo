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
  PageController pagecontroller ;
  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    pagecontroller = new PageController(initialPage: 0);

   // geTestHttp();
  }

  @override
  void dispose() {
    pagecontroller .dispose();
    super.dispose();
  }
  onPressSecondBtn(){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("点击了"),
        )
    );
  }

  List layoutlist = [
  AppHome(),
  project(),
  SeTup(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text("玩Android"),
        ),
        body:PageView.builder(
          onPageChanged:_onPageChanged,
          controller: pagecontroller,
          itemBuilder: (BuildContext context,int index){
           return layoutlist[index];
          },
          itemCount: 3,
        ),
            drawer: new Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.zero, /* padding置为0 */
                    child: Stack(
                      children: <Widget>[
                        Image.asset("assets/images/mantitle.png", fit: BoxFit.fill,width: double.infinity,),
                        Align( //放置对齐
                          alignment: FractionalOffset.bottomLeft,
                          child: Container(
                            height: 70.0,
                            margin: EdgeInsets.only(left: 12.0,bottom: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, /* 宽度只用包住子组件即可 */
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/timg.jpg'),
                                  radius: 35.0
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 6.0),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                                    mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                                    children: <Widget>[
                                      new Text("LYH", style: new TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),),
                                      new Text("What's up", style: new TextStyle(
                                          fontSize: 14.0, color: Colors.white),),
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),      //头部
                  ListTile(
                    title: Text("菜单1"),
                    onTap: () => menclick(1),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("菜单2"),
                    onTap: () => menclick(2),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("菜单3"),
                    onTap: () => menclick(3),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("菜单4"),
                    onTap: () => menclick(4),
                  ),
                  Divider(),
                ],
              )
            ), //侧方位菜单
            bottomNavigationBar: Material(
              color:Colors.white,
              child: BottomNavigationBar(items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("首页")
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.adb),
                  title: Text("项目")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.airplay),
                    title: Text("体系")
                ),
              ],
              currentIndex: _currentPageIndex,
                onTap: (index){
                  pagecontroller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },

              ),
            ),
    );

  }


  void onTextClear() {
    setState(() {
      phoneController.clear();
      phoneController2.clear();
    });
  }

  _onPageChanged( int index) {

    setState(() {
      _currentPageIndex = index;
    });
  }

  menclick(int i) {
    Navigator.of(context).pop();
   switch(i){
     case 1:
       print("菜单1");
       break;
     case 2:
       print("菜单2");
       break;
     case 3:
       print("菜单3");
       break;
     case 4:
       print("菜单4");
       break;

   }
  }
}






