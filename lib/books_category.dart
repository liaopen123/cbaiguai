import 'package:cbaiguai/model/book_item.dart';
import 'package:cbaiguai/util/string_sort_utils.dart';
import 'package:cbaiguai/view/city_item.dart';
import 'package:cbaiguai/view/stick_text_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'model/books_category.dart';

class BooksCategoryPage extends StatefulWidget {
  @override
  _BooksCategoryPageState createState() => _BooksCategoryPageState();
}

class _BooksCategoryPageState extends State<BooksCategoryPage> {
  final GlobalKey globalKey = GlobalKey(); //给widget 的key  获取对应的widget的高度
  List<BookItem> data = new List();
  double Xvalue = 0;
  double Yvalue = 0;
  bool showHint = false;
  bool reversed = false;
  double eachItemHeight;
  ItemPositionsListener itemPositionsListener;

  ItemScrollController _scrollController;

  int currentIndex = 999;

  String currentAlphabat = "A";

  @override
  void initState() {
    super.initState();
    _scrollController = new ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    if (data == null || data.length == 0) {
      return Scaffold(
          appBar: AppBar(
            title: Text("目录查询"),
          ),
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("目录查询"),
        ),
        body: Container(
          child: Stack(
            children: [
              ScrollablePositionedList.builder(
                  itemCount: data.length,
                  itemScrollController: _scrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return CityItem(
                        name: data[index].content,
                        showTitle: data[index].isTitleVisible());
                  }),
              positionsView,
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                //突然想到解决办法了    通过数据定位 就可以知道index的位置了 然后滚动了
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                    color: Colors.yellow),

                child: GestureDetector(
                  //手指按下时会触发此回调
                  onPanDown: (DragDownDetails e) {
                    _getWH(); //获取控件的高度
                    //打印手指按下的位置(相对于屏幕)
//                      print("用户手指按下相对于屏幕：${e.globalPosition}");
                    print("用户手指按下相对于控件：${e.localPosition}");
                    Xvalue = e.localPosition.dx;
                    Yvalue = e.localPosition.dy;
                    turn2Position(Yvalue);
                  },
                  //手指滑动时会触发此回调
                  onPanUpdate: (DragUpdateDetails e) {
                    //用户手指滑动时，更新偏移，重新构建
                    setState(() {
                      Xvalue += e.delta.dx;
                      Yvalue += e.delta.dy;
//                        print("用户手指移动相对于控件：$Xvalue。。。。$Yvalue");

                      turn2Position(Yvalue);
                    });
                  },
                  onPanEnd: (DragEndDetails e) {
                    //打印滑动结束时在x、y轴上的速度
                    print(e.velocity);
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        showHint = false;
                      });
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    key: globalKey,
                    children: getAZ(),
                  ),
                ),
              )),
            ],
          ),
        ),
      );
    }
  }

  void turn2Position(var Yvalue) {
    var index = (Yvalue / eachItemHeight).toInt();
    //当前字母
    if (index != currentIndex) {
      currentIndex = index;
      String currentAlphabat = String.fromCharCode("a".codeUnitAt(0) + index);
      print("当前位置:${currentAlphabat}");
      for (BookItem book in data) {
        if (book.firstLetter == currentAlphabat&&book.isTitleVisible()) {
          //找到位置进行滚动
          var position = book.position;
          print("当前position:$position");
          setState(() {
            showHint = true;
            this.currentAlphabat = currentAlphabat;
          });
          _scrollController.jumpTo(index: position, alignment: 0);
        }
      }
    }
  }

  List<Widget> getWidgets() {
    List<Widget> list = [];
    list.add(ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: data.length,
        itemBuilder: (_, index) {
          return CityItem(
              name: data[index].content,
              showTitle: data[index].isTitleVisible());
        }));
    if (showHint) {
      list.add(Align(
        alignment: Alignment.center,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.yellow),
          alignment: Alignment.center,
          child: Text(
            currentAlphabat,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ));
    }
    list.add(Positioned(
        child: Container(
      //突然想到解决办法了    通过数据定位 就可以知道index的位置了 然后滚动了
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          color: Colors.yellow),

      child: GestureDetector(
        //手指按下时会触发此回调
        onPanDown: (DragDownDetails e) {
          _getWH(); //获取控件的高度
          //打印手指按下的位置(相对于屏幕)
//                      print("用户手指按下相对于屏幕：${e.globalPosition}");
          print("用户手指按下相对于控件：${e.localPosition}");
          Xvalue = e.localPosition.dx;
          Yvalue = e.localPosition.dy;
          turn2Position(Yvalue);
        },
        //手指滑动时会触发此回调
        onPanUpdate: (DragUpdateDetails e) {
          //用户手指滑动时，更新偏移，重新构建
          setState(() {
            Xvalue += e.delta.dx;
            Yvalue += e.delta.dy;
//                        print("用户手指移动相对于控件：$Xvalue。。。。$Yvalue");

            turn2Position(Yvalue);
          });
        },
        onPanEnd: (DragEndDetails e) {
          //打印滑动结束时在x、y轴上的速度
          print(e.velocity);
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              showHint = false;
            });
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: globalKey,
          children: getAZ(),
        ),
      ),
    )));

    return list;
  }

  void _getWH() {
    final containerWidth = globalKey.currentContext.size.width;
    final containerHeight = globalKey.currentContext.size.height;
    eachItemHeight = containerHeight / 26;
    print(
        'Container widht is $containerWidth, height is $containerHeight,each height$eachItemHeight');
  }

  void getData() async {
    print("2333333");
    var dio = Dio();
    var response = await dio.get("http://192.168.0.102:8081/getGhostBooks");
    print("${response.data}");
    var homeDataEntity = BooksCategory.fromJson(response.data);
    var data = homeDataEntity.data;
    //筛选工作
    for (int index = 0; index < data.length; index++) {
      if (index == 0 ||
          PinYinUtils.getFirstPinyin(data[index].bookName) !=
              (PinYinUtils.getFirstPinyin(data[index - 1].bookName))) {
        String firstPinyin = PinYinUtils.getFirstPinyin(data[index].bookName);
        this.data.add(BookItem(firstPinyin, data[index].bookName, index,true),);
      } else {
        String firstPinyin = PinYinUtils.getFirstPinyin(data[index].bookName);
        this.data.add(BookItem(firstPinyin, data[index].bookName, index,false));
      }
    }

    setState(() {
      this.data;
    });
  }

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
    valueListenable: itemPositionsListener.itemPositions,
    builder: (context, positions, child) {
      int min;
      int max;
      if (positions.isNotEmpty) {
        // Determine the first visible item by finding the item with the
        // smallest trailing edge that is greater than 0.  i.e. the first
        // item whose trailing edge in visible in the viewport.
        min = positions
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce((ItemPosition min, ItemPosition position) =>
        position.itemTrailingEdge < min.itemTrailingEdge
            ? position
            : min)
            .index;
        // Determine the last visible item by finding the item with the
        // greatest leading edge that is less than 1.  i.e. the last
        // item whose leading edge in visible in the viewport.
        max = positions
            .where((ItemPosition position) => position.itemLeadingEdge < 1)
            .reduce((ItemPosition max, ItemPosition position) =>
        position.itemLeadingEdge > max.itemLeadingEdge
            ? position
            : max)
            .index;
      }
      //还得比较一下如果是上滑动 则得提前显示上一个字母
      if(data[min].firstLetter.isNotEmpty&&data[min].firstLetter!=currentAlphabat){
        currentAlphabat = data[min].firstLetter;


      }
      return StickTextBar(currentAlphabat);
    },
  );

  List<Widget> getAZ() {
    List<Widget> azlist = new List();
    int char = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (char <= end) {
      azlist.add(new Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            String.fromCharCode(char),
          )));
      char++;
    }
    return azlist;
  }
}
