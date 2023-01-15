import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/models/quizz.model.dart';
import '../services/http_services.dart';
import 'answer.widget.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({
    Key? key,
    required this.quizz,
  }) : super(key: key);

  Quizz quizz;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final HttpServices httpServices = HttpServices();
  var defaultImage =
      "https://www-practiceportuguese-com.exactdn.com/wp-content/uploads/2020/06/asking-questions.jpg?strip=all&lossy=1&ssl=1";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 8, right: 8),
      child: Column(
        children: [
          Container(
              height: 260,
              margin: const EdgeInsets.only(bottom: 10),
              child: widget.quizz.question.imageUrl != ""
                  ? Image.network(widget.quizz.question.imageUrl)
                  : Image.network(defaultImage)),
          Text(widget.quizz.question.value),
          const SizedBox(
            width: 300,
            child: Divider(thickness: 1),
          ),
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.quizz.answers.length,
            itemBuilder: (context, index) {
              return AnswerWidget(
                  quizz: widget.quizz, answer: widget.quizz.answers[index]);
            },
          )),
          OutlinedButton.icon(
              onPressed: () => {},
              icon: const FaIcon(FontAwesomeIcons.circleChevronRight,
                  color: Colors.redAccent),
              label: const Text(''))
        ],
      ),
    );
  }
}
