import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/models/quiz.model.dart';
import 'package:guess_my_w/widgets/question.widget.dart';
import 'package:guess_my_w/widgets/score.widget.dart';

import '../models/question.with.answers.model.dart';

class QuizzWidget extends StatefulWidget {
  const QuizzWidget(
      {super.key,
      required this.title,
      required this.userEmail,
      required this.quiz});

  final String title;
  final String userEmail;
  final Quiz quiz;

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  late QuestionWithAnswers quizz;
  int questioinCounter = 0;

  @override
  Widget build(BuildContext context) {
    if (questioinCounter < widget.quiz.questionWithAnswers.length) {
      quizz = widget.quiz.questionWithAnswers[questioinCounter++];
    }
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
            height: 600,
            child: QuestionWidget(quizz: quizz, userEmail: widget.userEmail)),
        OutlinedButton.icon(
            onPressed: () => {
                  setState(
                    () {
                      if (questioinCounter <
                          widget.quiz.questionWithAnswers.length) {
                        quizz =
                            widget.quiz.questionWithAnswers[questioinCounter];
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScoreWidget(
                                  quizId: widget.quiz.id,
                                  userEmail: widget.userEmail)),
                        );
                      }
                    },
                  )
                },
            icon: const FaIcon(FontAwesomeIcons.circleChevronRight,
                color: Colors.redAccent),
            label: const Text(''))
      ],
    ));
  }
}
