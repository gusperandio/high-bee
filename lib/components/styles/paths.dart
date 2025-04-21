import 'package:flutter/material.dart';

class RightSkewClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SebraeAppBarShape extends OutlinedBorder {
  Path _getPath(Rect rect) {
    final path = Path();
    final size = Size(rect.width, rect.height * 2);

    final startPoint = size.height * 0.25;
    final pointTwo = size.height * 0.25;

    path.lineTo(0, startPoint);
    path.lineTo(startPoint, pointTwo);
    path.lineTo(pointTwo - 10, pointTwo * 2);
    final endPoint = Offset(size.width, (pointTwo * 2));

    path.quadraticBezierTo(endPoint.dx, endPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return SebraeAppBarShape(side: side ?? this.side);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;

    canvas.drawPath(getOuterPath(rect), side.toPaint());
  }

  @override
  ShapeBorder scale(double t) {
    return SebraeAppBarShape(side: side.scale(t));
  }

  const SebraeAppBarShape({super.side});
}
