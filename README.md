# cbaiguai

A new Flutter application.

## 类似城市选择列表
![](https://github.com/liaopen123/ImageRepo/blob/master/app/src/main/res/raw/QQ20200310-201418.2020-03-10%2020_14_54.gif?raw=true)

先说一点：
Dart中**基本类型(Number、String、Boolean、List、Map、Runes、Symbol;)没有Char**,因此不能通过int char 转成A~Z，可以通过以下方法得到A~Z:
```dart
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
```

工具类 通过汉字获取拼音：[lpinyin](https://github.com/flutterchina/lpinyin)

看图就知道界面分为4块：
### 1.列表
因为列表需要有**滚动到具体position**的功能,再flutter_widgets库的[ScrollablePositionedList](https://pub.dev/documentation/flutter_widgets/latest/flutter_widgets/ScrollablePositionedList-class.html)就可以实现这个功能。但是在使用的时候发现一个坑:ScrollablePositionedList对位置的监听` itemPositionsListener: itemPositionsListener,`必须有数据的时候才能初始化ScrollablePositionedList Widget。第一次data为空，第二次通过setState赋值。这样子是不行了。简言之，必须在有数据的时候才能初始化列表:
```dart
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
     return ScrollablePositionedList().....
    }
```
### 头部置顶的sticker
这个简单 通过`Stack`布局叠加一个即可.

### 侧边的导航
这个布局不说,直说思路:
导航的Widge被26个字母等分。通过
```dart
//1.初始化globalKey
 final GlobalKey globalKey = GlobalKey(); //给widget 设定key  获取对应的widget的高度
 //2.赋值给Column
 Column(
            mainAxisSize: MainAxisSize.min,
            key: globalKey,
            ）,
 
 //3.得到导航栏整体的高度  这个并不是我们要的，我们直接需要的是每个字母所占的高度eachItemHeight ➗26就得到了。
  void _getWH() {
    final containerWidth = globalKey.currentContext.size.width;
    final containerHeight = globalKey.currentContext.size.height;
    eachItemHeight = containerHeight / 26;
    print(
        'Container widht is $containerWidth, height is $containerHeight,each height$eachItemHeight');
  }
 
 
 //3.给Column添加手势监听 通过手指所在的位置 判断出字母 显示出hint提示框
 //e.localPosition 是局部Widget的坐标
 //e.globalPosition 是相当于整个屏幕的坐标位置 没用到
 GestureDetector(
          //手指按下时会触发此回调
          onPanDown: (DragDownDetails e) {
            _getWH(); //获取控件的高度
            //打印手指按下的位置(相对于屏幕)
//                      print("用户手指按下相对于屏幕：${e.globalPosition}");
            print("用户手指按下相对于控件：${e.localPosition}");
            Yvalue = e.localPosition.dy;
            turn2Position(Yvalue);
          },
          //手指滑动时会触发此回调
          onPanUpdate: (DragUpdateDetails e) {
            //用户手指滑动时，更新偏移，重新构建
            setState(() {
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
         ）, 
         
```

#### 中间提示部分
这个也是通过`Stack`实现的，不难也不说。

          
