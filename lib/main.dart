import 'package:cbaiguai/view/page/books_category.dart';
import 'package:cbaiguai/model/HomeData.dart';
import 'package:cbaiguai/scrollable_positioned_list_example.dart';
import 'package:cbaiguai/test_list.dart';
import 'package:cbaiguai/view/page/article_page.dart';
import 'package:cbaiguai/view/page/home_page.dart';
import 'package:cbaiguai/view/page/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'common_webview_page.dart';


void main(){
//    debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}


