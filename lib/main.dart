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
    print("初始化");
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
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      image: DecorationImage(
                        image: AssetImage('mantitle.png')
                      )
                    ),
                  )
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
}






