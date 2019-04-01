import 'package:flutter/material.dart';

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

}

class mollectionbtnstate extends State<mollectionbtnwidgit>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon:setIcon() ,
      onPressed: (){

        setState(() {
        });
      },
    );
  }
  bool getclick(){
    return click;
   }
  bool click = false;
  setIcon(){
    print("点击收藏"+click.toString());
    if(click){
      click = false;
      return Icon(Icons.favorite);
    }else{
      click = true;
      return Icon(Icons.favorite_border);
    }
  }
}