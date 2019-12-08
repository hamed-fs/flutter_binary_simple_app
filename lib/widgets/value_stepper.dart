import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_binary_simple_app/theme/app_theme.dart';

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
  void didUpdateWidget(ValueStepper oldWidget) {
    _value = widget.initialValue;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lessProminent,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ToggleButtons(
        color: AppTheme.prominent,
        borderColor: AppTheme.lessProminent,
        borderRadius: BorderRadius.circular(5.0),
        children: <Widget>[
          Text('-', style: AppTheme.buttom),
          Text('${widget.prefix} ${_numberFormat.format(_value)}', style: AppTheme.caption),
          Text('+', style: AppTheme.buttom),
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
}
