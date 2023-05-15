import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/models/quiz.model.dart';
import 'package:guess_my_w/widgets/question.widget.dart';
import 'package:guess_my_w/widgets/score.widget.dart';

import '../models/question.with.answers.model.dart';
import '../services/http_services.dart';

class QuizzWidget extends StatefulWidget {
  const QuizzWidget({super.key, required this.title, required this.userEmail});

  final String title;
  final String userEmail;

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  final HttpServices httpServices = HttpServices();

  Quiz? quiz;
  late QuestionWithAnswers quizz;
  int questioinCounter = 0;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: httpServices.getQuizList(),
      builder: (context, AsyncSnapshot<List<Quiz>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          quiz = snapshot.data?[0];
          if (questioinCounter < quiz!.questionWithAnswers.length) {
            quizz = quiz!.questionWithAnswers[questioinCounter];
          }
          return Scaffold(
              body: Column(
            children: [
              SizedBox(height: 600, child: QuestionWidget(quizz: quizz, userEmail: widget.userEmail)),
              getStepButton(widget)
            ],
          ));
        } else {
          return const Text('Loading ...');
        }
      });

  Widget getStepButton(QuizzWidget widget) {
    return OutlinedButton.icon(
        onPressed: () => {
              setState(
                () {
                  if (questioinCounter < quiz!.questionWithAnswers.length) {
                    quizz = quiz!.questionWithAnswers[questioinCounter++];
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScoreWidget(userEmail: widget.userEmail)),
                    );
                  }
                },
              )
            },
        icon: const FaIcon(FontAwesomeIcons.circleChevronRight,
            color: Colors.redAccent),
        label: const Text(''));
  }
}
