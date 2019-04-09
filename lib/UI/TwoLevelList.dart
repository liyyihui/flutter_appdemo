import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/Tree.dart';
class TwoLevelList extends StatefulWidget{
  Tree mdata;
  TwoLevelList(this.mdata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TwoLevelListState(mdata);
  }

}

class TwoLevelListState extends State<TwoLevelList>{
  Tree mdata;
  TwoLevelListState(this.mdata):super();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return gettwomenview();
  }

  gettwomenview() {
    if(mdata!=null&&mdata.data.length>0){
      return ListView.builder(
          itemBuilder:  (BuildContext context, int position) {
            return ExpansionTile(
              title: Text(mdata.data[position].name),
              key: PageStorageKey(Children),
              initiallyExpanded: false,

            );
          },
         itemCount: mdata.data.length,
      );
    }else{
      return Text("无菜单数据");
    }

  }

}