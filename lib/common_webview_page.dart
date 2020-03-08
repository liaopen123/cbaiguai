import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonWebViewPage extends StatefulWidget {
  String _url;
  String _title;

  CommonWebViewPage(this._url,this._title);

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        appBar: AppBar(title: Text(widget._title,style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild:new Center(
          child: CircularProgressIndicator(),
        ),
        url: "${widget._url}");


  }
}
