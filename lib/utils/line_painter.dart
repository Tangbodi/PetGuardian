import 'package:flutter/material.dart';
import 'package:pet_guardian/utils/custom_color.dart';

class GradientLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          CustomColor.transDivderColor,
          CustomColor.dividerColor,
          CustomColor.transDivderColor,
        ],
        stops: [0.1, 0.5, 0.9],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 1.0 // Adjust the width of the line
      ..strokeCap = StrokeCap.butt; // Sharp ends

    canvas.drawLine(
      Offset(0, size.height / 2), // Start point
      Offset(size.width, size.height / 2), // End point
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
