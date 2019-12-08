import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

const int DECREAMENT = 0;
const int CALLBACK = 1;
const int INCREAMENT = 2;

class ValueStepper extends StatefulWidget {
  final double initialValue;
  final double stepSize;
  final String prefix;
  final NumberFormat numberFormat;

  final void Function(double) callback;

  const ValueStepper({this.initialValue = 0, this.stepSize = 1, this.prefix = '', this.numberFormat, this.callback});

  @override
  _ValueStepperState createState() => _ValueStepperState();
}

class _ValueStepperState extends State<ValueStepper> {
  double _value;
  NumberFormat _numberFormat;

  @override
  void initState() {
    _value = widget.initialValue;
    _numberFormat = widget.numberFormat ?? NumberFormat(',###.00');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ToggleButtons(
        color: Colors.white,
        selectedColor: Colors.black,
        fillColor: Colors.white,
        borderColor: Colors.grey,
        selectedBorderColor: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
        disabledColor: Colors.red,
        children: <Widget>[
          Text('-'),
          Text('${widget.prefix} ${_numberFormat.format(_value)}'),
          Text('+'),
        ],
        onPressed: (int index) => _doAction(index),
        isSelected: [false, false, false],
      ),
    );
  }

  void _doAction(int index) {
    switch (index) {
      case DECREAMENT:
        _value -= widget.stepSize;
        break;
      case CALLBACK:
        widget.callback(_value);
        break;
      case INCREAMENT:
        _value += widget.stepSize;
        break;
    }

    setState(() => _value);
  }

  void updateValue(double value) {
    setState(() => _value = value);
  }
}
