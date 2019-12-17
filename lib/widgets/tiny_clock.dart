import 'dart:math';

import 'package:flutter/material.dart';

const double CLOCK_ORIGIN = 3 * pi / 2;
const double CLOCK_HOUR_ANGLE = 30 * pi / 180;
const double CLOCK_MINUTE_ANGLE = 6 * pi / 180;

class TinyClock extends StatefulWidget {
  final int hour;
  final int minute;
  final Color color;
  final bool animate;
  final Duration duration12H;
  final double size;

  TinyClock({
    Key key,
    this.hour = 12,
    this.minute = 0,
    this.color = Colors.red,
    this.animate = true,
    this.duration12H = const Duration(seconds: 30),
    this.size = 150,
  }) : super(key: key);

  @override
  _TinyClockState createState() => _TinyClockState();
}

class _TinyClockState extends State<TinyClock> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _fastHandAnimation;
  Animation _slowHandAnimation;

  @override
  void initState() {
    if (widget.animate) {
      _animationController = AnimationController(duration: widget.duration12H, vsync: this)..addListener(() => setState(() {}));

      _fastHandAnimation = Tween<double>(begin: CLOCK_ORIGIN, end: 24 * pi + CLOCK_ORIGIN).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
      _slowHandAnimation = Tween<double>(begin: CLOCK_ORIGIN, end: 2 * pi + CLOCK_ORIGIN).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
      _animationController.repeat();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _TinyClockPainter(
          slowHandAngle: _slowHandAnimation != null ? _slowHandAnimation.value : CLOCK_ORIGIN + widget.hour % 12 * CLOCK_HOUR_ANGLE,
          fastHandAngel: _fastHandAnimation != null ? _fastHandAnimation.value : CLOCK_ORIGIN + widget.minute % 60 * CLOCK_MINUTE_ANGLE,
          color: widget.color,
        ),
      ),
    );
  }
}

class _TinyClockPainter extends CustomPainter {
  final double slowHandAngle;
  final double fastHandAngel;
  final Paint _clockPaint;
  final Paint _clockHandPaint;

  _TinyClockPainter({
    this.slowHandAngle,
    this.fastHandAngel,
    Color color,
  })  : _clockPaint = Paint()
          ..color = color.withOpacity(0.2)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2,
        _clockHandPaint = Paint()
          ..color = color
          ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    _drawClockFrame(canvas, center, size);
    _drawSlowHand(size, center, canvas);
    _drawFastHand(size, center, canvas);
  }

  void _drawClockFrame(Canvas canvas, Offset center, Size size) {
    canvas.drawCircle(center, size.width / 2, _clockPaint);
  }

  void _drawSlowHand(Size size, Offset center, Canvas canvas) {
    final slowHandLength = (size.width / 2) * 0.55;
    final handX = center.dx + cos(slowHandAngle) * slowHandLength;
    final handY = center.dx + sin(slowHandAngle) * slowHandLength;
    canvas.drawLine(center, Offset(handX, handY), _clockHandPaint);
  }

  void _drawFastHand(Size size, Offset center, Canvas canvas) {
    final fastHandLength = (size.width / 2) * 0.7;
    final handX = center.dx + cos(fastHandAngel) * fastHandLength;
    final handY = center.dx + sin(fastHandAngel) * fastHandLength;
    canvas.drawLine(center, Offset(handX, handY), _clockHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
