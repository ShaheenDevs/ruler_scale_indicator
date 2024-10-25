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
    this.minRange = 0.0,
    this.maxRange = 100.0,
    this.lineSpacing = 10.0,
    this.rulerHeight = 100.0,
    this.decimalPlaces = 1, // Default to 1 decimal place
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
        // Log the selected value
        log('Selected Position: ${_selectedPosition.toInt()}');
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomPaint(
                painter: ScaleRulerPainter(),
              ),
            ),
          ),
          Positioned(
            left: _selectedPosition,
            top: 0,
            child: Column(
              children: [
                Text(_selectedPosition.toStringAsFixed(1)),
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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double rulerHeight = size.height;
    double longLine = rulerHeight / 2;
    double mediumLine = rulerHeight / 3;
    double shortLine = rulerHeight / 4;

    for (double i = 0; i <= size.width; i += 10) {
      if (i % 50 == 0) {
        // Long line every 50 units
        canvas.drawLine(Offset(i, 0), Offset(i, longLine), paint);
        drawText(canvas, i.toInt().toString(), Offset(i, longLine + 5));
      } else if (i % 25 == 0) {
        // Medium line every 25 units
        canvas.drawLine(Offset(i, 0), Offset(i, mediumLine), paint);
      } else {
        // Short line every 10 units
        canvas.drawLine(Offset(i, 0), Offset(i, shortLine), paint);
      }
    }
  }

  void drawText(Canvas canvas, String text, Offset offset) {
    final textStyle = const TextStyle(
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
