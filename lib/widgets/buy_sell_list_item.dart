import 'package:flutter/material.dart';

class BuySellListItem extends StatefulWidget {
  @override
  _BuySellListItemState createState() => _BuySellListItemState();
}

class _BuySellListItemState extends State<BuySellListItem> with TickerProviderStateMixin {
  bool _isVisible = false;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    _isVisible = false;

    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = _isVisible && controller.isDismissed;

    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Row(
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
              Column(
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
              )
            ],
          ),
          Column(
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
                      onPressed: () {
                        if (controller.status == AnimationStatus.completed || controller.status == AnimationStatus.dismissed) {
                          setState(() {
                            _isVisible = !_isVisible;
                          });

                          _isVisible ? controller.forward() : controller.reverse();
                        }
                      },
                    ),
                  )
                ],
              ),
              AnimatedBuilder(
                animation: controller.view,
                builder: (BuildContext context, Widget chlid) => _buildExpandableWidget(),
                child: closed ? null : _buildExpandableWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableWidget() {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: animation.value,
        child: Transform(
          transform: Matrix4.diagonal3Values(1.0, controller.value, 1.0),
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
              SizedBox(height: 8.0)
            ],
          ),
        ),
      ),
    );
  }
}
