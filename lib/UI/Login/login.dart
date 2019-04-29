import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/Base/Utils.dart';
import 'package:flutter_app3/Ben/user.dart';
import 'package:flutter_app3/UI/Login/registered.dart';
import 'package:flutter_app3/UI/NetLoadingDialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class loginfulwidget extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginstate();
  }

}

class _loginstate extends State<loginfulwidget> {

  TextEditingController _namrcontroller ,_passwordcontroller;
  bool isname = true,ispaw = false;
  FocusNode namebode;
  FocusNode pawnode ;

  bool  login = false;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namrcontroller  =  TextEditingController();
    _passwordcontroller = TextEditingController();
     namebode = FocusNode();
     pawnode = FocusNode();
  }
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
        SizedBox(height: 80),
       _newusername(),
       SizedBox(height: 10),
       _userpassword(),
       SizedBox(height: 10),
       _forgetpassword(),
       SizedBox(height: 60),
       _loginbtn(),



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
         focusNode: pawnode,
         autofocus: ispaw,
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
             FocusScope.of(context).requestFocus(FocusNode());
             _login();
           }else{
             Utils.toast("请输入密码");
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
         FocusScope.of(context).requestFocus(pawnode);
      }else{
        Utils.toast("请输入账号");
      }

      },
      ),
      ),
    );
  }
   ///忘记密码
  _forgetpassword() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(height: 35,
         width: 150,
       child:  Row(
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
       ),

      )
    );
    
  }
  ///忘记密码点击
  _forgetpasswordclick() {

    Utils.toast("未开发");
  }

  _registeredclick() {
    print("注册");
    Navigator.push(context, new MaterialPageRoute(builder:(context) => new registered()));
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
                print("点击登陆");
                    _login();
              },
              child: Text("登陆",
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

   _login() {
    if(_namrcontroller.text.length<=0){
      Utils.toast("请输入账号");
      FocusScope.of(context).requestFocus(namebode);
      return ;
    } else if(_passwordcontroller.text.length<=0){
      Utils.toast("请输入密码");
      FocusScope.of(context).requestFocus(pawnode);
      return ;
    } else {

      SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      );
     _loginuser(_namrcontroller.text,_passwordcontroller.text);

    }

  }

   _loginuser(name,paw) async {
     _showDialog();
     FormData formData = new FormData.from({
       "username": name,
       "password": paw,
     });
     Response response = await Dio().post("https://www.wanandroid.com/user/login",data:formData );
     user  data = user.fromJson(response.data);
     print(response.toString());

     print("登陆账号"+name+"密码"+paw);

      if(data.errorCode!=0){
         login = false;
      Utils.toast(data.errorMsg);
      }else{
        login = true;
        Utils.toast("登陆成功"+data.data.toString());
        print("登陆返回"+data.data.username);
          String test = response.headers.toString().substring(response.headers.toString().indexOf("token_pass"),response.headers.toString().indexOf("loginUserName_wanandroid_com"));

        Utils.setlogininfo(name, paw, test.substring(test.indexOf("=")+1,test.indexOf(";")));

      }

     Navigator.pop(context);

   }



  _showDialog() {
      if(!login){
        showDialog<Null>(
          context: context,
          child: new NetLoadingDialog(
          ),
          barrierDismissible: false,

        );

      }else{
        setState(() {
          print("登陆成功");
        });
        return;
      }

  }

  __register(Function func) {
    func();
  }



}
