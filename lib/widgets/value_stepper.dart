import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_binary_simple_app/theme/app_theme.dart';

const int DECREAMENT = 0;
const int CALLBACK = 1;
const int INCREAMENT = 2;

class ValueStepper extends StatefulWidget {
  final double initialValue;
  final bool allowNegativeValue;
  final double stepSize;
  final String prefix;
  final NumberFormat numberFormat;

  final void Function(double) callback;

  const ValueStepper({
    this.initialValue = 0.0,
    this.allowNegativeValue = false,
    this.stepSize = 1.0,
    this.prefix = '',
    this.numberFormat,
    this.callback,
  });

  @override
  _ValueStepperState createState() => _ValueStepperState();
}

class _ValueStepperState extends State<ValueStepper> {
  double _value;
  NumberFormat _numberFormat;

  @override
  void initState() {
    _value = widget.initialValue;
    _numberFormat = widget.numberFormat ?? NumberFormat(',##0');

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
        renderBorder: false,
        color: AppTheme.prominent,
        borderRadius: BorderRadius.circular(5.0),
        children: <Widget>[
          Icon(Icons.remove),
          Container(child: Text('${widget.prefix} ${_numberFormat.format(_value)}', textAlign: TextAlign.center, style: AppTheme.buttom)),
          Icon(Icons.add),
        ],
        onPressed: (int index) => _react(index),
        isSelected: [false, false, false],
      ),
    );
  }

  void _react(int index) {
    switch (index) {
      case DECREAMENT:
        _value -= widget.stepSize;
        _value = _value < 0.0 && !widget.allowNegativeValue ? 0.0 : _value;

        setState(() => _value);
        break;
      case CALLBACK:
        widget.callback(_value);
        break;
      case INCREAMENT:
        _value += widget.stepSize;

        setState(() => _value);
        break;
    }
  }
}
