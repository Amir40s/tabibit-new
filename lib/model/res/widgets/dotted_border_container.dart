import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget child;

  const DottedBorderContainer({super.key,
    required this.width,
    required this.height,
    required this.borderColor,
    required this.strokeWidth,
    required this.dashWidth,
    required this.padding,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: DottedBorderPainter(
        borderColor: borderColor,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        borderRadius: 10,
      ),
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: child,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double borderRadius; // Added borderRadius property

  DottedBorderPainter({
    required this.borderColor,
    required this.strokeWidth,
    required this.dashWidth,
    required this.borderRadius, // Required borderRadius
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path();
    var rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Use Path to add RRect for rounded corners
    path.addRRect(rrect);

    double dashSpace = dashWidth * 1.5;
    PathMetrics pathMetrics = path.computeMetrics();

    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}