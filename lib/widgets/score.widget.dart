import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({super.key});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Mon Score Total est')),
    );
  }
}
