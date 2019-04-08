import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/Ben/Tree.dart';
import 'package:flutter_app3/UI/articlelistview.dart';
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
        shrinkWrap: true,
          itemBuilder:  (BuildContext context, int index) {
            return ExpansionTile(
              title: Text(mdata.data[index].name),
              onExpansionChanged: (bool){
              print(bool.toString());
              },
              initiallyExpanded: false,
             children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
                itemCount: mdata.data[index].children.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                    crossAxisCount: 3,
                    //纵轴间距
                    mainAxisSpacing: 5.0,
                    //横轴间距
                    crossAxisSpacing: 5.0,
                    //子组件宽高长度比例
                    childAspectRatio: 7/3
                ),
                itemBuilder: (BuildContext context, int positon){
                    return GestureDetector(
                      child: Card(
                        elevation: 20,  //z轴的高度，设置card的阴影
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(mdata.data[index].children[positon].name),

                        ),
                      ),
                      onTap: ()=>itemviewclick(mdata.data[index].children[positon].id),
                    );
                }

            )
             ],
            );
          },
         itemCount: mdata.data.length,
      );
    }else{
      return Text("无菜单数据");
    }

  }

  itemviewclick(int id) {
    print("点击的id"+id.toString());
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) => new articlelistview(id)),
    );
  }





}