import 'package:cbaiguai/view/city_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksCategoryPage extends StatefulWidget {
  @override
  _BooksCategoryPageState createState() => _BooksCategoryPageState();
}

class _BooksCategoryPageState extends State<BooksCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("tt"),),
    body: Container(
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (_,index){
            return CityItem(name:"name",showTitle:index%2==0);
          }),
    ),);
  }
}
