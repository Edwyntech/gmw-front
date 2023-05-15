import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/widgets/quizz.widget.dart';

import '../main.dart';
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
      future: httpServices.getQuizList(widget.userEmail),
      builder: (context, AsyncSnapshot<List<Quiz>> snapshot) {
        return Scaffold(
            appBar: AppBar(
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
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 100, left: 8, right: 8, bottom: 8),
              child: Column(
                children: [
                  snapshot.data == null
                      ? const Text("Loading...")
                      : Expanded(
                          child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ElevatedButton.icon(
                                    icon: !snapshot.data![index].done
                                        ? const FaIcon(FontAwesomeIcons.feather,
                                            color: Colors.deepOrangeAccent)
                                        : const FaIcon(FontAwesomeIcons.check,
                                            color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            snapshot.data![index].done
                                                ? Colors.white
                                                : Colors.deepOrange,
                                        backgroundColor:
                                            snapshot.data![index].done
                                                ? Colors.green
                                                : Colors.white),
                                    onPressed: () {
                                      if (!snapshot.data![index].done) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QuizzWidget(
                                                  quiz: snapshot.data![index],
                                                  title: "Quizz",
                                                  userEmail: widget.userEmail ??
                                                      'default')),
                                        );
                                      }
                                    },
                                    label: Text(
                                        snapshot.data![index].description +
                                            (snapshot.data![index].done
                                                ? ' (Completed)'
                                                : ''))),
                                const SizedBox(height: 10)
                              ],
                            );
                          },
                        )),
                ],
              ),
            ));
      });
}
