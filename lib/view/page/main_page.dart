import 'package:cbaiguai/view/page/article_page.dart';
import 'package:cbaiguai/view/page/books_category.dart';
import 'package:cbaiguai/view/page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _controller = new PageController();
  static int _currentIndex = 0;
  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(items.length==0){
    initBottomBar();
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          BooksCategoryPage(),
          ArticlePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: items,
        currentIndex: _currentIndex,
        onTap: (index){
        print(index);
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,),
    );
  }

  void initBottomBar() {

    List<Icon> icons = [
      Icon(Icons.home),
      Icon(Icons.list),
      Icon(Icons.create_new_folder),
    ];
    List<String> titles = ["首页", "目录", "杂谈"];
    for (int index = 0; index < icons.length; index++) {

      items.add(BottomNavigationBarItem(
        icon: icons[index],
        title: Text(titles[index]),
      ));
    }
  }
}
