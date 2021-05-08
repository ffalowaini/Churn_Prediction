
import 'package:flutter/material.dart';

class TrianglePainterDown extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal[900]
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 1 / 3, 0);
    path.lineTo(size.width * 2 / 3, 0);
    path.lineTo(size.width * 1 / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}