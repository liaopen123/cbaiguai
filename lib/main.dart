import 'package:cbaiguai/books_category.dart';
import 'package:cbaiguai/model/HomeData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common_webview_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '鬼怪'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RefreshController _refreshController = new RefreshController();
  int pageNum = 1;
  List<Data>  homeData = new List();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if(homeData.length==0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(),
            footer: ClassicFooter(),
            child: ListView.builder(
                itemCount: homeData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: childItem(homeData[index]),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new BooksCategoryPage()));
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new CommonWebViewPage(homeData[index].ghostLink,homeData[index].ghostName)));

                    },
                  );
                }),
            onRefresh: ()async{
              pageNum=1;
              getData();
              _refreshController.refreshCompleted();
            },
            onLoading: ()async{
              pageNum++;
              getData();
              _refreshController.loadComplete();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }




  }

  Widget childItem(Data homeDataData) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            Image.network(
              homeDataData.ghostAvatar,
              width: 100,
              height: 100,
            ),
            Expanded(
              child:   Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(     homeDataData.ghostName,style: TextStyle(fontSize: 20),),
                  Padding(padding: EdgeInsets.only(top: 10),child:  Text(homeDataData.ghostDes,style: TextStyle(fontSize: 15),),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() async{
    print("2333333");
    var dio = Dio();
    var response = await dio.get("http://192.168.0.102:8081/getGhostList?page=${pageNum}");
    print("${response.data}");
    var homeDataEntity = HomeData.fromJson(response.data);
    var data = homeDataEntity.data;
    if(pageNum==1){
      homeData.clear();
    }
    setState(() {
      homeData.addAll(data);
    });


  }



  Widget childItem1(Data homeDataData) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            Image.network(
              "http://www.cbaigui.com/wp-content/uploads/2019/10/中国妖怪百集loading-320x320.jpg",
              width: 100,
              height: 100,
            ),
            Expanded(
              child:   Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("homeDataData.ghostName",style: TextStyle(fontSize: 20),),
                  Text("homeDataDatahomeDataDatahomeDataDatahomeDataDatahomeDataDatahomeDataData.ghostDes",style: TextStyle(fontSize: 15),),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
