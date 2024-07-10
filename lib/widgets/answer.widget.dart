import 'package:flutter/material.dart';
import 'package:guess_my_w/models/answer-check.model.dart';
import 'package:guess_my_w/models/answer.model.dart';
import 'package:guess_my_w/models/question.with.answers.model.dart';
import 'package:guess_my_w/services/http_services.dart';

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({
    Key? key,
    required this.quizz,
    required this.answer,
    required this.userEmail,
    required this.hasBeenValidated,
    required this.onVerifyAnswer,
  }) : super(key: key);

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
      answered = false;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: answered ? Colors.white : Colors.deepOrange,
        backgroundColor: answered
            ? (validAnswer ? Colors.green : Colors.deepOrange.shade700)
            : Colors.white,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () {
        if (!widget.hasBeenValidated) {
          AnswerCheckModel chosenAnswer = AnswerCheckModel(
            questionId: widget.quizz.question.id,
            answerId: widget.answer.id,
            userEmail: widget.userEmail,
          );
          httpServices.verifyAnswer(chosenAnswer).then((value) {
            setState(() {
              validAnswer = value;
            });
            widget.onVerifyAnswer(true);
            answered = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          widget.answer.value,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
