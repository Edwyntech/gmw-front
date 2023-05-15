import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/main.dart';
import 'package:guess_my_w/models/quiz.model.dart';
import 'package:guess_my_w/widgets/question.widget.dart';
import 'package:guess_my_w/widgets/quiz.choice.widget.dart';
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
  late QuestionWithAnswers quizz =
      widget.quiz.questionWithAnswers[questioinCounter];
  int questioinCounter = 0;
  bool hasBeenValidated = false;

  void onVerifyAnswer(bool isValidated) {
    setState(() {
      hasBeenValidated = isValidated;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            SizedBox(
                height: 600,
                child: QuestionWidget(
                    quizz: quizz,
                    onVerifyAnswer: onVerifyAnswer,
                    hasBeenValidated: hasBeenValidated,
                    userEmail: widget.userEmail)),
            IconButton(
                icon: const Icon(FontAwesomeIcons.circleChevronRight),
                color: Colors.deepOrangeAccent,
                onPressed: () => {
                      if (hasBeenValidated)
                        {
                          setState(
                            () {
                              if (++questioinCounter <
                                  widget.quiz.questionWithAnswers.length) {
                                quizz = widget
                                    .quiz.questionWithAnswers[questioinCounter];
                                hasBeenValidated = false;
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
                        }
                    })
          ],
        ));
  }
}
