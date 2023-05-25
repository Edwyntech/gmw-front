import 'package:flutter/material.dart';
import 'package:guess_my_w/models/score.model.dart';
import 'package:guess_my_w/widgets/quiz.choice.widget.dart';

import '../main.dart';
import '../services/http_services.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({super.key, required this.quizId, required this.userEmail});

  final int quizId;
  final String userEmail;

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  final HttpServices httpServices = HttpServices();

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: httpServices.getScore(widget.userEmail, widget.quizId),
      builder: (context, AsyncSnapshot<Score> snapshot) {
        var myScore = snapshot.data?.score;
        var maxScore = snapshot.data?.maxScore;
        var myMessage = snapshot.data?.text;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.list),
              tooltip: 'Quiz selection',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QuizChoiceWidget(userEmail: widget.userEmail)),
                );
              },
            ),
            title: const Text(''),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Log out',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 100, left: 8, right: 8),
            child: SizedBox(
              height: 600.0,
              child: Center(
                  child: snapshot.data == null
                      ? const Text("Loading...")
                      : Column(
                          children: [
                            Text(
                              '$myScore/$maxScore' ?? '0',
                              style: TextStyle(
                                  fontSize: 80, color: Colors.deepOrange),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                              child: Text(
                                textAlign: TextAlign.center,
                                myMessage ?? 'default',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Image.network(
                                "assets/assets/images/winning.gif",
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
