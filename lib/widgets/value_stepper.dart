import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_binary_simple_app/theme/app_theme.dart';

const int DECREAMENT = 0;
const int INCREAMENT = 1;
const int CALLBACK = 2;

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
      child: Material(
        color: AppTheme.lessProminentColor,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                child: Icon(Icons.remove, color: AppTheme.prominentColor),
                onTap: () => _react(DECREAMENT),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 80.0),
              child: Container(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
                    child: Text(
                      '${widget.prefix} ${_numberFormat.format(_value)}',
                      style: AppTheme.valueStepperStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () => _react(CALLBACK),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                child: Icon(Icons.add, color: AppTheme.prominentColor),
                onTap: () => _react(INCREAMENT),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _react(int action) {
    switch (action) {
      case DECREAMENT:
        _value -= widget.stepSize;
        _value = _value < 0.0 && !widget.allowNegativeValue ? 0.0 : _value;

        setState(() => _value);
        break;
      case CALLBACK:
        widget?.callback(_value);
        break;
      case INCREAMENT:
        _value += widget.stepSize;

        setState(() => _value);
        break;
    }
  }
}
