library ruler_scale_indicator;

import 'dart:developer';
import 'package:flutter/material.dart';

/// A customizable scale ruler widget.
class ScaleRuler extends StatefulWidget {
  final double minRange; // Minimum value of the range
  final double maxRange; // Maximum value of the range
  final double lineSpacing; // Spacing between each line
  final double rulerHeight; // Height of the ruler
  final int decimalPlaces; // Number of decimal places to show

  const ScaleRuler({
    super.key,
    required this.minRange,
    required this.maxRange,
    required this.lineSpacing,
    required this.rulerHeight,
    required this.decimalPlaces,
  });

  @override
  _ScaleRulerState createState() => _ScaleRulerState();
}

class _ScaleRulerState extends State<ScaleRuler> {
  double _selectedPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Update the selected position based on drag
          _selectedPosition += details.delta.dx;

          // Constrain the position within the widget width
          _selectedPosition = _selectedPosition.clamp(
              0.0, MediaQuery.of(context).size.width - 40);
        });

        // Calculate and log the selected value
        double selectedValue = widget.minRange +
            (_selectedPosition /
                (MediaQuery.of(context).size.width - 40) *
                (widget.maxRange - widget.minRange));
        log('Selected Value: ${selectedValue.toStringAsFixed(widget.decimalPlaces)}');
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
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
                ),
              ),
            ),
          ),
          Positioned(
            left: _selectedPosition,
            top: 0,
            child: Column(
              children: [
                Text(
                  (_selectedPosition /
                              (MediaQuery.of(context).size.width - 40) *
                              (widget.maxRange - widget.minRange) +
                          widget.minRange)
                      .toStringAsFixed(widget.decimalPlaces),
                ),
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.red,
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

  ScaleRulerPainter({
    required this.minRange,
    required this.maxRange,
    required this.lineSpacing,
    required this.rulerHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double longLine = rulerHeight / 2;
    double mediumLine = rulerHeight / 3;
    double shortLine = rulerHeight / 4;

    // Calculate the number of lines based on minRange, maxRange, and lineSpacing
    double range = maxRange - minRange;
    int numLines = (range / lineSpacing).ceil();

    for (int i = 0; i <= numLines; i++) {
      double x = i * size.width / numLines;
      double currentValue = minRange + i * lineSpacing;

      if (currentValue % 50 == 0) {
        // Long line every 50 units
        canvas.drawLine(Offset(x, 0), Offset(x, longLine), paint);
        drawText(
            canvas, currentValue.toStringAsFixed(0), Offset(x, longLine + 5));
      } else if (currentValue % 25 == 0) {
        // Medium line every 25 units
        canvas.drawLine(Offset(x, 0), Offset(x, mediumLine), paint);
      } else {
        // Short line for other units
        canvas.drawLine(Offset(x, 0), Offset(x, shortLine), paint);
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
