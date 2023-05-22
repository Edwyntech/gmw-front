import 'package:flutter/material.dart';
import 'package:guess_my_w/models/question.with.answers.model.dart';
import 'package:photo_view/photo_view.dart';

import '../services/http_services.dart';
import 'answer.widget.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({
    Key? key,
    required this.quizz,
    required this.hasBeenValidated,
    required this.userEmail,
    required this.onVerifyAnswer,
  }) : super(key: key);

  QuestionWithAnswers quizz;
  String userEmail;
  bool hasBeenValidated;
  final void Function(bool) onVerifyAnswer;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final HttpServices httpServices = HttpServices();

  var defaultImage = "assets/images/asking-questions.webp";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: 260,
              margin: const EdgeInsets.only(bottom: 10),
              child: widget.quizz.question.imageUrl != ""
                  ? PhotoView(
                      backgroundDecoration: BoxDecoration(color: Colors.transparent),
                      imageProvider:
                          NetworkImage(widget.quizz.question.imageUrl))
                  : PhotoView(
                      backgroundDecoration: BoxDecoration(color: Colors.transparent),
                      imageProvider: AssetImage(defaultImage))),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            //apply padding to some sides only
            child:
                Text(widget.quizz.question.value, textAlign: TextAlign.center),
          ),
          const SizedBox(
            width: 300,
            child: Divider(thickness: 1),
          ),
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.quizz.answers.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: AnswerWidget(
                    quizz: widget.quizz,
                    answer: widget.quizz.answers[index],
                    userEmail: widget.userEmail,
                    onVerifyAnswer: widget.onVerifyAnswer,
                    hasBeenValidated: widget.hasBeenValidated,
                  ));
            },
          )),
        ],
      ),
    );
  }
}
