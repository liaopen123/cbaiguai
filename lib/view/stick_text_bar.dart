import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StickTextBar extends StatelessWidget {
  String name;
  StickTextBar(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xffe9ecef),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Text(name,style: TextStyle(color: Colors.black,fontSize: 18),),
    );
  }
}
