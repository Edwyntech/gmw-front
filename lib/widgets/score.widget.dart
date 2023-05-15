import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:guess_my_w/models/score.model.dart';

import '../services/http_services.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({super.key});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {

  final HttpServices httpServices = HttpServices();
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: httpServices.getScore("kabermoustapha", 1),
      builder: (context, AsyncSnapshot<Score> snapshot) {

      var myScore = snapshot.data?.score;
      var myMessage = snapshot.data?.text;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 250, left: 8, right: 8),
            child: SizedBox(
              height: 600.0,
              child: Center(child: Column(
                children: [
                  Text(myScore.toString() ?? '0', style: TextStyle(fontSize: 80, color: Colors.orange),),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(myMessage ?? 'default', style: TextStyle(fontSize: 18),),
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
      });
}
