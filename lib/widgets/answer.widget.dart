import 'package:flutter/material.dart';

import '../models/answer-check.model.dart';
import '../models/answer.model.dart';
import '../models/question.with.answers.model.dart';
import '../services/http_services.dart';

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({
    Key? key,
    required this.quizz,
    required this.answer,
    required this.userName,
  }) : super(key: key);

  final QuestionWithAnswers quizz;
  final Answer answer;
  final String userName;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  bool answered = false;
  bool validAnswer = false;

  final HttpServices httpServices = HttpServices();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: answered
                ? (validAnswer ? Colors.lightGreen : Colors.red)
                : null,
            minimumSize: const Size.fromHeight(40)),
        onPressed: () {
          answered = true;
          AnswerCheckModel chosenAnswer;
          chosenAnswer =
              AnswerCheckModel(widget.quizz.question.id, widget.answer.id, widget.userName);
          httpServices.verifyAnswer(chosenAnswer).then((value) {
            setState(() {
              validAnswer = value;
            });
          });
        },
        child: Text(widget.answer.value));
  }
}
