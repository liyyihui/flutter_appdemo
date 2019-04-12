import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils{
    static Future<String>  getloginname() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return  await  prefs.get("name").toString();
    }

    static Future<String> getloginpassword() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
       return  await prefs.get("paw").toString();
    }

    static Future<String>  getlogincookie() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return  await prefs.get("cookie").toString();
    }


    static setlogininfo(String name,String password,String cookie) async {
      print("进来"+name);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", name);
      prefs.setString("paw", password);
      prefs.setString("cookie", cookie);

    }

    static clearlogininfo() async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

    }

    static toast(String msg){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black45
      );
    }
}