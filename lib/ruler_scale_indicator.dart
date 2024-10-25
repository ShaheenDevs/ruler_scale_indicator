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
    this.alignmentPosition = AlignmentPosition.top, // Default alignment
  });

  @override
  _ScaleRulerState createState() => _ScaleRulerState();
}

class _ScaleRulerState extends State<ScaleRuler> {
  final ScrollController _scrollController = ScrollController();
  double _selectedPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    double scaleWidth =
        (widget.maxRange - widget.minRange) / widget.lineSpacing * 20;

    return Column(
      children: [
        Stack(
          children: [
            // Scrollable scale ruler
            Padding(
              padding: EdgeInsets.only(
                  top: widget.alignmentPosition == AlignmentPosition.top
                      ? 60
                      : 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left:  200, right: 200),
                  child: CustomPaint(
                    size: Size(scaleWidth, widget.rulerHeight),
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
            ),
            // Red pointer indicator
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment:
                    widget.alignmentPosition == AlignmentPosition.bottom
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  if (widget.alignmentPosition == AlignmentPosition.top) ...[
                    _buildPointer(),
                  ],
                  if (widget.alignmentPosition == AlignmentPosition.bottom) ...[
                    _buildPointer(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPointer() {
    return Column(
      children: [
        if (_scrollController.hasClients) // Check if controller is attached
          Text(
            (_selectedPosition /
                        (_scrollController.position.maxScrollExtent /
                            (widget.maxRange - widget.minRange)) +
                    widget.minRange)
                .toStringAsFixed(widget.decimalPlaces),
          ),
        Container(
          width: 2,
          height: widget.rulerHeight / 2,
          color: Colors.red,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _selectedPosition = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      double currentValue = minRange + i * lineSpacing;

      // Calculate the y offset based on alignment
      double lineStart =
          alignmentPosition == AlignmentPosition.bottom ? size.height : 0;
      double lineEnd = alignmentPosition == AlignmentPosition.bottom
          ? size.height -
              (i % 5 == 0 ? longLine : (i % 2 == 0 ? mediumLine : shortLine))
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
