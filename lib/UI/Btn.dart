import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class mollectionbtn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mollectionbtnwidgit();
  }
}

class mollectionbtnwidgit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mollectionbtnstate();
  }
  bool getclick(){
    return false;
  }
}

class mollectionbtnstate extends State<mollectionbtnwidgit>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon:setIcon() ,
      onPressed: (){
           print("点击");
        setState(() {
        });
      },
    );
  }
  bool getclick(){
    return click;
   }
  bool click = false;
  int index = 0;
  setIcon(){
    if(index == 0 || index == 1){
      index = ++index;
      return Icon(Icons.favorite_border);
    }
    if(!click){
      click = true;
      Fluttertoast.showToast(
          msg: "收藏成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
         );

      return Icon(Icons.favorite);
    }else{
     Fluttertoast.showToast(
  msg: "取消收藏",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIos: 1,
     );
     click = false;
     return Icon(Icons.favorite_border);
  }

    }

}