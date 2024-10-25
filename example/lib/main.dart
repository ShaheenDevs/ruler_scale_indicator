import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ruler_scale_indicator/ruler_scale_indicator.dart'; // Import using your package name

void main() {
  runApp(const ScaleRulerExampleApp());
}

class ScaleRulerExampleApp extends StatelessWidget {
  const ScaleRulerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Scale Ruler Example')),
        body:  Center(
          child: ScaleRuler(
            minRange: 0,
            maxRange: 10,
            lineSpacing: 0.2,
            rulerHeight: 120,
            decimalPlaces: 1,
            onChange: (e){
              log("======>$e");
            },
          ),
        ),
      ),
    );
  }
}
