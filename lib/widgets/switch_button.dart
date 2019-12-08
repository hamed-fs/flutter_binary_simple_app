import 'package:flutter/material.dart';

import 'package:flutter_binary_simple_app/theme/app_theme.dart';

class SwitchButton extends StatefulWidget {
  final bool canDeselect;
  final int defaultSelection;
  final List<String> labels;
  final double width;

  final void Function(int) callback;

  const SwitchButton({
    @required this.labels,
    this.defaultSelection = 0,
    this.canDeselect = false,
    this.width = 200.0,
    this.callback,
  });

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  double _width;
  List<bool> _isSelected;

  @override
  void initState() {
    _width = widget.width / widget.labels.length;

    _initializeButtons();

    super.initState();
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
        selectedColor: AppTheme.disabled,
        fillColor: AppTheme.prominent,
        borderRadius: BorderRadius.circular(5.0),
        children: widget.labels
            .map(
              (String label) => Container(
                width: _width,
                child: Text(
                  label,
                  style: AppTheme.buttom,
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
        onPressed: (int index) {
          widget.callback(index);

          setState(() => _handleButtonSelection(index));
        },
        isSelected: _isSelected,
      ),
    );
  }

  void _initializeButtons() {
    int defaultSelection = widget.defaultSelection >= widget.labels.length || widget.defaultSelection < 0 ? 0 : widget.defaultSelection;

    _isSelected = [];

    for (int i = 0; i < widget.labels.length; i++) {
      _isSelected.add(i == defaultSelection);
    }
  }

  void _handleButtonSelection(int index) {
    for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
      _isSelected[buttonIndex] = buttonIndex == index ? !widget.canDeselect || !_isSelected[buttonIndex] : false;
    }
  }
}
