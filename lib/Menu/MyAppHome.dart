import 'package:flutter/material.dart';
import 'package:flutter_app3/Menu/Setup.dart';
import 'package:flutter_app3/Menu/home.dart';
import 'package:flutter_app3/Menu/project.dart';

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
      body:

      PageView.builder(
        onPageChanged:_onPageChanged,
        controller: pagecontroller,
        itemBuilder: (BuildContext context,int index){
          return layoutlist[index];
        },
        itemCount: layoutlist.length,
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
                              GestureDetector(
                                child:   CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/timg.jpg'),
                                  radius: 35.0,

                                ),
                                onTap:()=>avatarclick()
                              ),


                           
                            Container(
                                margin: EdgeInsets.only(left: 6.0),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                                  mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                                  children: <Widget>[
                                    new GestureDetector(
                                      child: Text("未登陆", style: new TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),

                                      ),
                                      onTap: ()=>loginclick(),
                                    ),
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
                title: Text("我的收藏"),
                trailing: Icon(Icons.keyboard_arrow_right),

                onTap: () => menclick(1),
              ),
              Divider(),
              ListTile(
                title: Text("切换账号"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => menclick(2),
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

  loginclick() {

    print("登陆点击");
  }

  avatarclick() {
    print("头像点击");

  }
}