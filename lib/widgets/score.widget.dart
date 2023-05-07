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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 250, left: 8, right: 8),
        child: Container(
            height: 600.0,
            child: Center(child: Column(
              children: [
                const Text("7/10", style: TextStyle(fontSize: 80, color: Colors.orange),),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text("Bravo! vous avez obtenu votre meilleur score", style: TextStyle(fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    "assets/images/winning.gif",
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
              ],
            )),
        ),
      ),
    );
  }
}
