import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_contacts_app/shared/models/segment_model.dart';

class SegmentedGaugeChart extends StatelessWidget {
  const SegmentedGaugeChart({Key? key, required this.segments, required this.width, required this.height}) : super(key: key);

  final List<SegmentModel> segments;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SegmentPainter(segments: segments),
      child: SizedBox(
        width: width, // Set your desired width
        height: height, // and height
      ),
    );
  }
}

class SegmentPainter extends CustomPainter {
  final List<SegmentModel> segments;

  SegmentPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -pi / 2; // Start angle for the first segment
    const strokeWidth = 10.0; // Width of the stroke
    final radius = min(size.width, size.height) / 2;
    final total = segments.fold(0, (sum, item) => sum + item.value);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    segments.forEach((segment) {
      final sweepAngle = (segment.value / total) * 2 * pi;
      paint.color = segment.color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
