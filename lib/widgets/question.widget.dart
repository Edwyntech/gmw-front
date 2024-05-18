import 'package:flutter/material.dart';
import 'package:guess_my_w/models/question.with.answers.model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:guess_my_w/services/http_services.dart';
import 'package:guess_my_w/widgets/answer.widget.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
    required this.quizz,
    required this.hasBeenValidated,
    required this.userEmail,
    required this.onVerifyAnswer,
  }) : super(key: key);

  final QuestionWithAnswers quizz;
  final String userEmail;
  final bool hasBeenValidated;
  final void Function(bool) onVerifyAnswer;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final HttpServices httpServices = HttpServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildImageContainer(),
          _buildQuestionText(),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.quizz.answers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: AnswerWidget(
                    quizz: widget.quizz,
                    answer: widget.quizz.answers[index],
                    userEmail: widget.userEmail,
                    onVerifyAnswer: widget.onVerifyAnswer,
                    hasBeenValidated: widget.hasBeenValidated,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    final imageUrl = widget.quizz.question.imageUrl;
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 10),
      child: imageUrl != ""
          ? PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          imageProvider: NetworkImage(imageUrl))
          : PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          imageProvider: NetworkImage("assets/assets/images/asking-questions.webp")),
    );
  }

  Widget _buildQuestionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        widget.quizz.question.value,
        textAlign: TextAlign.center,
      ),
    );
  }
}