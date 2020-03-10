import 'package:cbaiguai/util/string_sort_utils.dart';
import 'package:cbaiguai/view/stick_text_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  String name;
  bool showTitle;

  CityItem({this.name, this.showTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getCityItem(this.name, this.showTitle),
    );
  }

  List<Widget> getCityItem(String name, bool showTitle) {
    List<Widget> list = new List();
    if (showTitle) {
      list.add(StickTextBar(PinYinUtils.getFirstPinyin(name)));
    }
    list.add(Container(
      width: double.infinity,
      color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(name,style: TextStyle(fontSize: 20),)));
    return list;
  }
}
