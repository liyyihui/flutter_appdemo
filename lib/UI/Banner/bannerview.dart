
import 'package:flutter/material.dart';
class LyhBanner extends StatefulWidget {
    var url;
    LyhBanner({Key key,@required  this.url}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BannerWidget( url: url);
  }

}

class BannerWidget extends State<LyhBanner>{
  List<String> url ;
  BannerWidget({Key key,@required  this.url});
  PageController _pageController ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mpagview();
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for( int i= 0;i<url.length;i++){
       print("获取到的路径"+url[i]);
    }
    _pageController = PageController();

  }

  mpagview(){
      return PageView.builder(
          itemBuilder:(context,index){
              return Image(
                image: NetworkImage(url[index]),
              );
          },
        //页面数量
         itemCount: url.length,
        //水平滑动还是垂直滑动
        scrollDirection: Axis.horizontal,
        //是否反方向
        reverse: false,
        controller: _pageController,
        onPageChanged: (index){
            print("滑动到"+index.toString());
        },
      );
  }
}