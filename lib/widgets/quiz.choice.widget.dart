import 'package:flutter/material.dart';
import 'package:guess_my_w/widgets/quizz.widget.dart';

import '../models/quiz.model.dart';
import '../services/http_services.dart';

class QuizChoiceWidget extends StatefulWidget {
  QuizChoiceWidget({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  String userEmail;

  @override
  State<QuizChoiceWidget> createState() => _QuizChoiceWidgetState();
}

class _QuizChoiceWidgetState extends State<QuizChoiceWidget> {
  final HttpServices httpServices = HttpServices();

  void onVerifyAnswer(int selectedQuizId) {
    setState(() {
      selectedQuizId = selectedQuizId;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: httpServices.getQuizList(),
      builder: (context, AsyncSnapshot<List<Quiz>> snapshot) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 8, right: 8, bottom: 8),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizzWidget(
                                      quiz: snapshot.data![index],
                                      title: "Quizz",
                                      userEmail:
                                          widget.userEmail ?? 'default')),
                            );
                          },
                          child: Text(snapshot.data![index].id.toString())),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              )),
            ],
          ),
        );
      });
}
