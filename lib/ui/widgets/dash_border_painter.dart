import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var strokeWidth = 1.0;
    var margin = 20.0; // Adjust this value to change the margin
    var path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(margin + strokeWidth / 2, strokeWidth / 2,
              size.width - 2 * margin - strokeWidth, size.height - strokeWidth),
          Radius.circular(10)));
    var paint = Paint()
      ..color = Color(0xFF3392F1)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    var dashedPath = dashPath(path,
        dashArray: CircularIntervalList<double>(<double>[10.0, 5.0]));
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
