import 'package:cbaiguai/model/book_item.dart';
import 'package:cbaiguai/util/string_sort_utils.dart';
import 'package:cbaiguai/view/city_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'model/books_category.dart';

class BooksCategoryPage extends StatefulWidget {
  @override
  _BooksCategoryPageState createState() => _BooksCategoryPageState();
}

class _BooksCategoryPageState extends State<BooksCategoryPage> {
  final GlobalKey globalKey = GlobalKey();//给widget 的key  获取对应的widget的高度
  List<BookItem> data = new List();
  double Xvalue=0;
  double Yvalue=0;
  bool showHint = false;

  double eachItemHeight;

  ItemScrollController _scrollController;

  int currentIndex=999;

  String currentAlphabat="";
  @override
  void initState() {
    super.initState();
    _scrollController = new ItemScrollController();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var list = getAZ();
    if (data==null) {
      return Center(child: CircularProgressIndicator(),);

    }else{

      return Scaffold(appBar: AppBar(title: Text("目录查询"),),
        body: Container(
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: data.length,
                  itemBuilder: (_,index){
                  print("currentIndex:$index");

                    return CityItem(name:data[index].content,showTitle:data[index].isTitleVisible());
                  }),

             Align(
               alignment: Alignment.center,
               child: Container(
                 height: 100,
                 width: 100,

                 decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),color: Colors.yellow),
                 alignment: Alignment.center,
                child:  Text(currentAlphabat,style: TextStyle(fontSize: 20),),
               ),
             ),

             Positioned(child: Container(
               //突然想到解决办法了    通过数据定位 就可以知道index的位置了 然后滚动了
                 padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),color: Colors.yellow),

                  child:GestureDetector(
                    //手指按下时会触发此回调
                    onPanDown: (DragDownDetails e) {
                      _getWH();
                      //打印手指按下的位置(相对于屏幕)
                      print("用户手指按下相对于屏幕：${e.globalPosition}");
                      print("用户手指按下相对于控件：${e.localPosition}");
                      Xvalue = e.localPosition.dx;
                      Yvalue = e.localPosition.dy;

                    },
                    //手指滑动时会触发此回调
                    onPanUpdate: (DragUpdateDetails e) {
                      //用户手指滑动时，更新偏移，重新构建
                      setState(() {
                        Xvalue += e.delta.dx;
                        Yvalue += e.delta.dy;
//                        print("用户手指移动相对于控件：$Xvalue。。。。$Yvalue");

                        var index = (Yvalue/eachItemHeight).toInt();
                        //当前字母
                        if(index!=currentIndex){
                          currentIndex =index;
                          String currentAlphabat = String.fromCharCode("a".codeUnitAt(0)+index);
                          print("当前位置:${currentAlphabat}");
                          for(BookItem book in data){
                            if(book.firstLetter==currentAlphabat){
                              //找到位置进行滚动
                              var position = book.position;
                              print("当前position:$position");
                              this.currentAlphabat = currentAlphabat;
//                              _scrollController.animateTo((position+currentIndex)*80.0, duration: new Duration(milliseconds: 500), curve: Curves.ease);
                              _scrollController.jumpTo(index: position, alignment: 0);
//                              _scrollController.animateTo(i * _ITEM_HEIGHT,
//                                  duration: new Duration(seconds: 2), curve: Curves.ease);
//                            }

                            }
                          }
                        }


                      });
                    },
                    onPanEnd: (DragEndDetails e) {
                      //打印滑动结束时在x、y轴上的速度
                      print(e.velocity);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      key: globalKey,
                      children:getAZ(),
                    ),
                  ),
                )),

            ],
          ),
        ),);
    }
    }


  void _getWH() {
    final containerWidth = globalKey.currentContext.size.width;
    final containerHeight = globalKey.currentContext.size.height;
     eachItemHeight = containerHeight/26;
    print('Container widht is $containerWidth, height is $containerHeight,each height$eachItemHeight');
  }

  void getData() async{
    print("2333333");
    var dio = Dio();
    var response = await dio.get("http://192.168.0.102:8081/getGhostBooks");
    print("${response.data}");
    var homeDataEntity = BooksCategory.fromJson(response.data);
    var data = homeDataEntity.data;
    //筛选工作
    for(int index=0;index<data.length;index++){
      if(index==0||PinYinUtils.getFirstPinyin(data[index].bookName)!=(PinYinUtils.getFirstPinyin(data[index-1].bookName))){
        String firstPinyin = PinYinUtils.getFirstPinyin(data[index].bookName);
        this.data.add(BookItem(firstPinyin, data[index].bookName,index),) ;
      }else{
        this.data.add(BookItem("", data[index].bookName,index)) ;
      }
    }

    setState(() {
   this.data;
    });


  }

   List<Widget> getAZ(){
    List<Widget> azlist = new List();
    int char= "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while(char<=end){
      azlist.add(new  Padding(  padding: EdgeInsets.symmetric(horizontal: 5),child: Text(String.fromCharCode(char),)) );
      char++;
    }
    return azlist;

  }

}
