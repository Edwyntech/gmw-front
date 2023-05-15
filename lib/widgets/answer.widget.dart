import 'package:flutter/material.dart';

import '../models/answer-check.model.dart';
import '../models/answer.model.dart';
import '../models/question.with.answers.model.dart';
import '../services/http_services.dart';

class AnswerWidget extends StatefulWidget {
  const AnswerWidget(
      {Key? key,
      required this.quizz,
      required this.answer,
      required this.userEmail,
      required this.hasBeenValidated,
      required this.onVerifyAnswer})
      : super(key: key);

  final QuestionWithAnswers quizz;
  final Answer answer;
  final String userEmail;
  final bool hasBeenValidated;
  final void Function(bool) onVerifyAnswer;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  bool answered = false;
  bool validAnswer = false;

  final HttpServices httpServices = HttpServices();

  @override
  Widget build(BuildContext context) {
    if (!widget.hasBeenValidated) {
      setState(() {
        answered = false;
      });
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: answered ? Colors.white : Colors.deepOrange,
            backgroundColor: answered
                ? (validAnswer ? Colors.green : Colors.deepOrange.shade900)
                : Colors.white,
            minimumSize: const Size.fromHeight(40)),
        onPressed: () {
          if (!widget.hasBeenValidated) {
            AnswerCheckModel chosenAnswer;
            chosenAnswer = AnswerCheckModel(
                widget.quizz.question.id, widget.answer.id, widget.userEmail);
            httpServices.verifyAnswer(chosenAnswer).then((value) {
              setState(() {
                validAnswer = value;
              });
              widget.onVerifyAnswer(true);
              answered = true;
            });
          }
        },
        child: Text(widget.answer.value));
  }
}
