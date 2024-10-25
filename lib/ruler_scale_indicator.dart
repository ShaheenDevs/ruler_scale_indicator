library ruler_scale_indicator;

import 'dart:developer';
import 'package:flutter/material.dart';

/// Enum for alignment position
enum AlignmentPosition { top, bottom }

/// A customizable scale ruler widget.
class ScaleRuler extends StatefulWidget {
  final double minRange; // Minimum value of the range
  final double maxRange; // Maximum value of the range
  final double lineSpacing; // Spacing between each line
  final double rulerHeight; // Height of the ruler
  final int decimalPlaces; // Number of decimal places to show
  final AlignmentPosition alignmentPosition; // Alignment of the scale

  const ScaleRuler({
    super.key,
    required this.minRange,
    required this.maxRange,
    required this.lineSpacing,
    required this.rulerHeight,
    required this.decimalPlaces,
    this.alignmentPosition = AlignmentPosition.bottom, // Default alignment
  });

  @override
  _ScaleRulerState createState() => _ScaleRulerState();
}

class _ScaleRulerState extends State<ScaleRuler> {
  double _selectedPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width - 40;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _selectedPosition += details.delta.dx;
          _selectedPosition = _selectedPosition.clamp(0.0, widgetWidth);
        });

        // Calculate and log the selected value
        double selectedValue = widget.minRange +
            (_selectedPosition /
                widgetWidth *
                (widget.maxRange - widget.minRange));
        log('Selected Value: ${selectedValue.toStringAsFixed(widget.decimalPlaces)}');
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: widget.rulerHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomPaint(
                painter: ScaleRulerPainter(
                  minRange: widget.minRange,
                  maxRange: widget.maxRange,
                  lineSpacing: widget.lineSpacing,
                  rulerHeight: widget.rulerHeight,
                  alignmentPosition: widget.alignmentPosition,
                ),
              ),
            ),
          ),
          Positioned(
            left: _selectedPosition,
            bottom: widget.alignmentPosition == AlignmentPosition.bottom ? 0 : null,
            top: widget.alignmentPosition == AlignmentPosition.top ? 0 : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.red,
                ),
                Text(
                  (_selectedPosition /
                              widgetWidth *
                              (widget.maxRange - widget.minRange) +
                          widget.minRange)
                      .toStringAsFixed(widget.decimalPlaces),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScaleRulerPainter extends CustomPainter {
  final double minRange; // Minimum value of the range
  final double maxRange; // Maximum value of the range
  final double lineSpacing; // Spacing between each line
  final double rulerHeight; // Height of the ruler
  final AlignmentPosition alignmentPosition; // Alignment of the scale

  ScaleRulerPainter({
    required this.minRange,
    required this.maxRange,
    required this.lineSpacing,
    required this.rulerHeight,
    required this.alignmentPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double longLine = rulerHeight / 2;
    double mediumLine = rulerHeight / 3;
    double shortLine = rulerHeight / 4;

    // Calculate the number of lines
    double range = maxRange - minRange;
    int numLines = (range / lineSpacing).ceil();

    // Ensure at least 10 lines for small ranges
    numLines = numLines < 10 ? 10 : numLines;

    for (int i = 0; i <= numLines; i++) {
      double x = i * size.width / numLines;
      double currentValue = minRange + i * (range / numLines);

      // Calculate the y offset based on alignment
      double lineStart = alignmentPosition == AlignmentPosition.bottom
          ? size.height
          : 0;
      double lineEnd = alignmentPosition == AlignmentPosition.bottom
          ? size.height - (i % 5 == 0 ? longLine : (i % 2 == 0 ? mediumLine : shortLine))
          : (i % 5 == 0 ? longLine : (i % 2 == 0 ? mediumLine : shortLine));

      // Draw the scale lines
      canvas.drawLine(Offset(x, lineStart), Offset(x, lineEnd), paint);

      // Draw numbers for long lines
      if (i % 5 == 0) {
        double textYOffset = alignmentPosition == AlignmentPosition.bottom
            ? size.height - longLine - 15
            : longLine + 5;

        drawText(
          canvas,
          currentValue.toStringAsFixed(0),
          Offset(
            x - currentValue.toStringAsFixed(0).length * 3,
            textYOffset,
          ),
        );
      }
    }
  }

  void drawText(Canvas canvas, String text, Offset offset) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: 100);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
