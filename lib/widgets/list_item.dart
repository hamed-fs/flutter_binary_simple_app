import 'package:flutter/material.dart';

class MyListItem extends StatefulWidget {
  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  bool _isVisible = false;

  @override
  void initState() {
    _isVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 4.0),
                Text('Solidsnake78', style: TextStyle(fontSize: 13.0, color: Colors.white)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'You pay IDR',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '1,406,581.00',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Price IDR/USD',
                          style: TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '14,059.40',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Available USD',
                          style: TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '5,024.74',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
                ButtonTheme(
                  height: 24.0,
                  minWidth: 64.0,
                  child: FlatButton(
                    child: Text(
                      'BUY',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                    color: Colors.red,
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                  ),
                )
              ],
            ),
            _isVisible
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Instructions',
                          style: TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Please send funds to Mybank account',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                        Text(
                          '54646545645646',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
