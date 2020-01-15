import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final Color centralDotColor;
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Color dotFourColor;
  final Color dotFiveColor;
  final Color dotSixColor;
  final Color dotSevenColor;
  final Color dotEightColor;
  final double centralDotRadius;
  final double outerDotRadius;
  final double spanRadius;
  final Duration duration;

  Loader({
    Key key,
    this.centralDotColor = Colors.grey,
    this.dotOneColor = Colors.red,
    this.dotTwoColor = Colors.lightBlue,
    this.dotThreeColor = Colors.orange,
    this.dotFourColor = Colors.green,
    this.dotFiveColor = Colors.yellow,
    this.dotSixColor = Colors.blue,
    this.dotSevenColor = Colors.pink,
    this.dotEightColor = Colors.lightGreen,
    this.centralDotRadius = 15.0,
    this.spanRadius = 30.0,
    this.duration = const Duration(seconds: 3),
    this.outerDotRadius = 5.0,
  }) : super(key: key);

  _LoaderState createState() => _LoaderState(centralDotRadius);
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _animationRotation;
  Animation<double> _animationRadiusIn;
  Animation<double> _animationRadiusOut;

  final double _initialRadius;

  double _radius = 0.0;

  _LoaderState(this._initialRadius);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.75,
          1.0,
          curve: Curves.elasticIn,
        ),
      ),
    );

    _animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.elasticOut,
        ),
      ),
    );

    _animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    _controller.addListener(() {
      if (_controller.value >= 0.75 && _controller.value <= 1.0) {
        setState(() => _radius = _animationRadiusIn.value * _initialRadius);
      } else if (_controller.value >= 0.0 && _controller.value <= 0.25) {
        setState(() => _radius = _animationRadiusOut.value * _initialRadius);
      }
    });

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: Center(
        child: RotationTransition(
          turns: _animationRotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: widget.centralDotRadius,
                color: widget.centralDotColor,
              ),
              Transform.translate(
                offset: Offset(
                  cos(pi / 4) * _radius,
                  sin(pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotOneColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(2 * pi / 4) * _radius,
                  sin(2 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotTwoColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(3 * pi / 4) * _radius,
                  sin(3 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotThreeColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(pi) * _radius,
                  sin(pi) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotFourColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(5 * pi / 4) * _radius,
                  sin(5 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotFiveColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(6 * pi / 4) * _radius,
                  sin(6 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotSixColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(7 * pi / 4) * _radius,
                  sin(7 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotSevenColor,
                ),
              ),
              Transform.translate(
                offset: Offset(
                  cos(8 * pi / 4) * _radius,
                  sin(8 * pi / 4) * _radius,
                ),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotEightColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({
    Key key,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
