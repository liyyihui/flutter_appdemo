import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class mollectionbtnwidgit extends StatefulWidget{
  final DrawerCallback callback;
  bool click = false;
   mollectionbtnwidgit({Key key,this.callback,this.click}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mollectionbtnstate(click);
  }
}

class mollectionbtnstate extends State<mollectionbtnwidgit>{

  bool click ;
  mollectionbtnstate( this.click,{Key key});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon:setIcon() ,
      onPressed: (){
        setState(() {
        });

        if(widget.callback!=null){
          widget.callback(click);
          print("进回调");
        }

      },
    );
  }

  setIcon(){

    if(!click){
      click = true;
      return Icon(Icons.favorite);
    }else{
     click = false;
     return Icon(Icons.favorite_border);
  }

    }

}