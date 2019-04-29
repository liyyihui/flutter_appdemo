import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Base/Utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class registered extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _registeredwidget();
  }

}

class _registeredwidget  extends State<registered>{
  TextEditingController _namrcontroller ,_passwordcontroller,_passwordcontroller2;
  bool isname = true,ispaw = false;
  FocusNode namebode;
  FocusNode pawnode1 ;
  FocusNode pawnode2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namrcontroller = new   TextEditingController();
    _passwordcontroller = new   TextEditingController();
    _passwordcontroller2 = new   TextEditingController();
    namebode = new FocusNode();
    pawnode1 = new FocusNode();
    pawnode2 = new FocusNode();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
        centerTitle: true,
      ),
      body: getlayout(),
    );
  }


  getlayout() {

    return ListView(
        children: <Widget>[
    Column(
    children: <Widget>[
        _buildtitle(),
    _buildtitleline(),
    SizedBox(height: 80),
    _newusername(),
    SizedBox(height: 10),
    _userpassword(),
    SizedBox(height: 10),
        _userpassword2(),
    SizedBox(height: 60),
        _loginbtn(),
      ])
    ]);
  }

  ///头部
  _buildtitle(){
    return Padding(
        padding: EdgeInsets.all(8.0),
        child:  Align(
          alignment: Alignment.centerLeft,
          child: Text("WanAndroid",
            style:TextStyle(fontSize: 42.0) ,
          ),
        )
    );
  }
  ///头部下的横线
  _buildtitleline(){
    return Padding(
      padding: EdgeInsets.only(left: 12.0,top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  ///用户密码输入框
  _userpassword() {
    return  Container(
      child: SizedBox(width: 250,height: 45,
        child: TextField(
          focusNode: pawnode1,

          controller: _passwordcontroller,
          decoration: InputDecoration(
              hintText: "请输入密码",
              prefixIcon: Icon(Icons.https),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),
          // obscureText: true,
          onEditingComplete: (){
            if(_passwordcontroller.text.length>=1){
              FocusScope.of(context).requestFocus(pawnode2);

            }else{
              Utils.toast("请输入密码");
              return;
            }
          },
        ),
      ),
    );

  }
  ///用户密码输入框
  _userpassword2() {
    return  Container(
      child: SizedBox(width: 250,height: 45,
        child: TextField(
          focusNode: pawnode2,

          controller: _passwordcontroller2,
          decoration: InputDecoration(
              hintText: "请输入确认密码",
              prefixIcon: Icon(Icons.https),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),
          // obscureText: true,
          onEditingComplete: (){
            if(_passwordcontroller2.text.length>=1){
              FocusScope.of(context).requestFocus(FocusNode());

            }else{
              Utils.toast("请输入确认密码密码");
              return;
            }
          },
        ),
      ),
    );

  }
  ///用户名
  _newusername() {
    return Container(
      // color: Colors.blue,
      child: SizedBox(width: 250,
        height: 45,
        child: TextField(
          focusNode: namebode,
          autofocus: isname,
          controller: _namrcontroller,
          decoration: InputDecoration(
              hintText: "请输入账号",
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),
          onEditingComplete: (){

            if(_namrcontroller.text.length>=1){
              FocusScope.of(context).requestFocus(pawnode1);
            }else{
              Utils.toast("请输入账号");
            }

          },
        ),
      ),
    );
  }

  ///登陆按钮
  _loginbtn() {
    return Container(
      child: SizedBox(
        width: 200,
        height: 40,
        child:Material(
            child: FlatButton(
              onPressed: (){
                print("点击注册");
              registered_user();
              },
              child: Text("注册",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
            )
        ) ,
      ),
    );
  }
   ///提交注册数据
   registered_user() {
     if(_namrcontroller.text.length<=0){
       Utils.toast("请输入注册账号");
     }else if(_passwordcontroller.text.length<=0){
       Utils.toast("请输入注册密码");
     }else if(_passwordcontroller.text != _passwordcontroller2.text){
       Utils.toast("两次密码不相同");
     }else{
     //  Utils.toast("去提交");
       _post_userinfo(_namrcontroller.text,_passwordcontroller2.text);
     }
  }

   _post_userinfo(String name, String paw) async {
     Response response = await Dio().post("https://www.wanandroid.com/user/register",data:{
       "username":name.toString() ,"password":paw.toString(),"repassword":paw} );
    print(response.toString());

   }

}//类结束括号



