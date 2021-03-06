import 'package:flutter/material.dart';

import 'package:flutter_binary_simple_app/widgets/buy_sell_list_item.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black, height: 0.5);
        },
        itemBuilder: (condex, index) {
          return BuySellListItem();
        },
      ),
    );
  }
}
