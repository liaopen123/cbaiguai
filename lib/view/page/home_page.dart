import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = new PageController();
  static int _currentIndex = 0;
  List<BottomNavigationBarItem> items = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initBottomBar();
    return Scaffold(
      appBar: AppBar(
        title: Text("只妖"),
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
            child: Text("222"),
          ),
          Center(
            child: Text("222"),
          ),
          Center(
            child: Text("222"),
          ),
          Center(
            child: Text("222"),
          ),
          Center(
            child: Text("222"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: items,
        currentIndex: _currentIndex,
        onTap: (index){
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
      Icon(Icons.tab),
      Icon(Icons.perm_device_information)
    ];
    List<String> titles = ["首页", "目录", "杂谈", "夜谭", "关于"];

    for (int index = 0; index < icons.length; index++) {
      items.add(BottomNavigationBarItem(
        icon: icons[index],
        title: Text(titles[index]),
      ));
    }
  }
}
