import 'package:cbaiguai/model/article_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common_webview_page.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> with AutomaticKeepAliveClientMixin{
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
          title: Text("天方夜谭"),
        ),
        body: Container(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: ClassicHeader(),
            footer: ClassicFooter(),
            child: ListView.builder(
                itemCount: homeData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: childItem(homeData[index]),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new CommonWebViewPage(homeData[index].articleLink,homeData[index].articleTitle)));

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
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child:   Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(homeDataData.articleTitle,style: TextStyle(fontSize: 20,color: Color(0xff333333)),),
                    Padding(padding: EdgeInsets.only(top: 10),child:  Text(homeDataData.articleDes,style: TextStyle(fontSize: 15,color: Color(0xff999999)),),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async{
    print("2333333");
    var dio = Dio();
    var response = await dio.get("http://192.168.0.102:8081/getArticle");
    print("${response.data}");
    var homeDataEntity = ArticleList.fromJson(response.data);
    var data = homeDataEntity.data;
    setState(() {
      homeData.addAll(data);
    });


  }

  @override
  bool get wantKeepAlive => true;



}
