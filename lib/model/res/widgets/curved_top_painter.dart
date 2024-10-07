import 'package:flutter/material.dart';

class CurvedTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Start the curve higher up by adjusting the first value
    path.moveTo(
        0,
        size.height *
            0.45); // Increase the 0.7 to 0.5 or lower to increase the height
    path.quadraticBezierTo(
      size.width / 2,
      size.height *
          0.2, // Set this to 0 to have the curve reach the top of the canvas
      size.width,
      size.height * 0.45, // Mirror the moveTo adjustment here
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
