import 'package:flutter/material.dart';
class loginfulwidget extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginstate();
  }

}

class _loginstate extends State<loginfulwidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
   body: _loginbody(),
    );
  }
   ///登陆页面主布局
  _loginbody() {
   return ListView(
       children: <Widget>[
         Column(
     children: <Widget>[
       _buildtitle(),
       _buildtitleline(),
        SizedBox(height: 40),
       _newusername(),
       SizedBox(height: 10),
       _userpassword(),
       SizedBox(height: 10),
       _forgetpassword(),
     ],
   ),
       ],

   );
  }

  ///头部
 _buildtitle(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child:  Align(
        alignment: Alignment.centerLeft,
        child: Text("Login",
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
         autofocus: false,
         decoration: InputDecoration(
           hintText: "请输入密码",
           prefixIcon: Icon(Icons.https),
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15)
           ),
           contentPadding: EdgeInsets.symmetric(vertical: 10)
         ),
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
        autofocus: true,
       
      decoration: InputDecoration(
        hintText: "请输入账号",
        prefixIcon: Icon(Icons.account_circle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
      
        ),
          contentPadding: EdgeInsets.symmetric(vertical: 10)
      ),

      ),
      ),
    );
  }
   ///忘记密码
  _forgetpassword() {
    return Align(
      alignment: Alignment.topRight,
      child:Row(

        children: <Widget>[

          GestureDetector(
            child: Text("没有账号",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: ()=>_registeredclick(),
          ),
          GestureDetector(
            child: Text("忘记密码？"),
            onTap: ()=>_forgetpasswordclick(),
          ),
        ],
      )
    );
    
  }
  ///忘记密码点击
  _forgetpasswordclick() {

    print("忘记密码");
  }

  _registeredclick() {
    print("注册");

  }
}