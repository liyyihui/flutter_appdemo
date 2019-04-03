import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
typedef void SwiperOnTap(bool isok);

class mollectionbtn extends StatelessWidget{
  final SwiperOnTap onTap;

  const mollectionbtn({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mollectionbtnwidgit(onTap: onTap,);
  }
}

class mollectionbtnwidgit extends StatefulWidget{

  final SwiperOnTap onTap;

   mollectionbtnwidgit({Key key, this.onTap}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mollectionbtnstate(onTap);
  }
}

class mollectionbtnstate extends State<mollectionbtnwidgit>{
  final SwiperOnTap onmTap;


  mollectionbtnstate(SwiperOnTap onTap, {Key key, this.onmTap});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon:setIcon() ,
      onPressed: (){
        setState(() {
        });
           if(onmTap!=null){
             onmTap(click);
             print("进来回调");
           }
        print("没进回调");
      },
    );
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