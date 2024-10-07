import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final double dotLength;
  final double spacing;
  final Color color;
  final Axis direction;
  final double? length;

  const DottedLine({
    super.key,
    this.height = 1,
    this.dotLength = 4,
    this.spacing = 4,
    this.color = Colors.black,
    this.direction = Axis.horizontal,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: direction == Axis.horizontal
          ? Size(length ?? double.infinity, height)
          : Size(height, length ?? double.infinity),
      painter: _DottedLinePainter(
        height: height,
        dotLength: dotLength,
        spacing: spacing,
        color: color,
        direction: direction,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final double height;
  final double dotLength;
  final double spacing;
  final Color color;
  final Axis direction;

  _DottedLinePainter({
    required this.height,
    required this.dotLength,
    required this.spacing,
    required this.color,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = height;

    double startX = 0;
    double startY = 0;
    final isHorizontal = direction == Axis.horizontal;

    while (isHorizontal ? startX < size.width : startY < size.height) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(
          isHorizontal ? startX + dotLength : startX,
          isHorizontal ? startY : startY + dotLength,
        ),
        paint,
      );
      if (isHorizontal) {
        startX += dotLength + spacing;
      } else {
        startY += dotLength + spacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}