import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;

  CustomProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
    this.startAngle = 180, // Default starting from left horizontal
    this.sweepAngle = 270, // Default 3/4 of a circle
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;

    // Background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth * 0.5 // Make background stroke thicker
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle * pi / 180, // Convert to radians
      sweepAngle * pi / 180, // Convert to radians
      false,
      backgroundPaint,
    );

    // Creating the progress arc with gradient
    final progressPaint = Paint()
      ..strokeWidth = strokeWidth * 0.5 // Make progress stroke thicker
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressRect = Rect.fromCircle(center: center, radius: radius);

    // Define the start and end points for the gradient based on the arc
    final startAngleRad = startAngle * pi / 180;
    final endAngleRad = (startAngle + sweepAngle * progress) * pi / 180;

    // Calculate the points on the arc for gradient
    final startPoint = Offset(center.dx + radius * cos(startAngleRad),
        center.dy + radius * sin(startAngleRad));

    final endPoint = Offset(center.dx + radius * cos(endAngleRad),
        center.dy + radius * sin(endAngleRad));

    // Apply the gradient directly from AppColors
    progressPaint.shader = AppColors.purpleIndicatorGradient
        .createShader(Rect.fromPoints(startPoint, endPoint));

    // Draw the progress arc
    canvas.drawArc(
      progressRect,
      startAngleRad,
      (endAngleRad - startAngleRad),
      false,
      progressPaint,
    );

    // Calculate the position of the tip of the progress arc
    final tipX = center.dx + radius * cos(endAngleRad);
    final tipY = center.dy + radius * sin(endAngleRad);

    // Draw a larger circle at the tip of the progress arc
    final tipPaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(tipX, tipY), 4.5, tipPaint); // Increased size from 3.5 to 4.5
  }

  @override
  bool shouldRepaint(CustomProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle;
  }
}
