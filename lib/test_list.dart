import 'package:cbaiguai/view/city_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
  List<String> lists=new List();

  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    List<String> data=new List();
    List.generate(100, (index) {
      data.add("liaopeng :$index");
    });
    lists.addAll(data);

      return Scaffold(
        appBar: AppBar(
          title: Text("test"),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              ScrollablePositionedList.builder(
                  itemCount: 100,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return Container(child: CityItem(
                        name: lists[index], showTitle: index % 2 == 0),);
                  }),
              positionsView,
            ],
          ),
        ),
      );
  }


  Widget get positionsView =>
      ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int min;
          int max;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge
                ? position
                : min)
                .index;
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            max = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
            position.itemLeadingEdge > max.itemLeadingEdge
                ? position
                : max)
                .index;
          }
          return Row(
            children: <Widget>[
              Expanded(child: Text('First Item: ${min ?? ''}')),
              Expanded(child: Text('Last Item: ${max ?? ''}')),
              const Text('Reversed: '),
              Checkbox(
                  value: false,
                  onChanged: (bool value) => setState(() {}))
            ],
          );
        },
      );

  void loadData() {
    List<String> data=new List();
    Future.delayed(Duration(seconds: 3),(){

      List.generate(100, (index) {
        data.add("liaopeng :$index");
      });
      setState(() {
        lists.addAll(data);
      });

    });
  }
}
