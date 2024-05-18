import 'package:flutter/material.dart';
import 'package:guess_my_w/models/score.model.dart';
import 'package:guess_my_w/widgets/quiz.choice.widget.dart';

import '../main.dart';
import '../services/http_services.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({
    Key? key,
    required this.quizId,
    required this.userEmail,
  }) : super(key: key);

  final int quizId;
  final String userEmail;

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  final HttpServices httpServices = HttpServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Score>(
      future: httpServices.getScore(widget.userEmail, widget.quizId),
      builder: (context, AsyncSnapshot<Score> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              leading: IconButton(
                icon: const Icon(Icons.list),
                tooltip: 'Quiz selection',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizChoiceWidget(userEmail: widget.userEmail),
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              leading: IconButton(
                icon: const Icon(Icons.list),
                tooltip: 'Quiz selection',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizChoiceWidget(userEmail: widget.userEmail),
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            body: const Center(child: Text('Error fetching score')),
          );
        } else {
          final myScore = snapshot.data!.score;
          final maxScore = snapshot.data!.maxScore;
          final myMessage = snapshot.data!.text;

          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              leading: IconButton(
                icon: const Icon(Icons.list),
                tooltip: 'Quiz selection',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizChoiceWidget(userEmail: widget.userEmail),
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: SizedBox(
                height: 600.0,
                child: Column(
                  children: [
                    Text(
                      '$myScore/$maxScore' ?? '0',
                      style: const TextStyle(fontSize: 80, color: Colors.deepOrange),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                      child: Text(
                        myMessage ?? 'default',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Image(image: AssetImage("assets/images/winning.gif")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
