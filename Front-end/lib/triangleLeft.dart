import 'package:flutter/material.dart';

class TrianglePainterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal[600]
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height * 1 / 2);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}