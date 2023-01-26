import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/widgets/question.widget.dart';
import 'package:guess_my_w/widgets/score.widget.dart';

import '../models/quizz.model.dart';
import '../services/http_services.dart';

class QuizzWidget extends StatefulWidget {
  const QuizzWidget({super.key, required this.title});

  final String title;

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  final HttpServices httpServices = HttpServices();

  List<Quizz>? quizzList;
  late Quizz quizz;
  int questioinCounter = 0;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: httpServices.getQuizzList(),
      builder: (context, AsyncSnapshot<List<Quizz>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          quizzList = snapshot.data;
          if (questioinCounter < quizzList!.length) {
            quizz = quizzList![questioinCounter];
          }
          return Scaffold(
              body: Column(
            children: [
              SizedBox(height: 600, child: QuestionWidget(quizz: quizz)),
              getStepButton()
            ],
          ));
        } else {
          return const Text('Loading ...');
        }
      });

  Widget getStepButton() {
    return OutlinedButton.icon(
        onPressed: () => {
              setState(
                () {
                  if (questioinCounter < quizzList!.length) {
                    quizz = quizzList![questioinCounter++];
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScoreWidget()),
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
