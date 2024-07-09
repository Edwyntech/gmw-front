import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/widgets/quizz.widget.dart';

import '../main.dart';
import '../models/quiz.model.dart';
import '../services/http_services.dart';

class QuizChoiceWidget extends StatefulWidget {
  final String userEmail;

  const QuizChoiceWidget({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<QuizChoiceWidget> createState() => _QuizChoiceWidgetState();
}

class _QuizChoiceWidgetState extends State<QuizChoiceWidget> {
  final HttpServices httpServices = HttpServices();

  Future<List<Quiz>> getQuizzesWithScore() async {
    try {
      final quizList = await httpServices.getQuizList(widget.userEmail);
      return Future.wait(quizList.map((quiz) async {
        if (quiz.done) {
          return Quiz(
            id: quiz.id,
            description: quiz.description,
            done: true,
            questionWithAnswers: quiz.questionWithAnswers,
            score: await httpServices.getScore(widget.userEmail, quiz.id),
          );
        } else {
          return quiz;
        }
      }));
    } catch (e) {
      throw 'Error fetching quiz list: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: getQuizzesWithScore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          final quizList = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(''),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            body: _buildQuizList(quizList),
          );
        }
      },
    );
  }

  Widget _buildQuizList(List<Quiz> quizList) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(50),
              itemCount: quizList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final quiz = quizList[index];
                return ElevatedButton.icon(
                  icon: quiz.done
                      ? const FaIcon(FontAwesomeIcons.check,
                          color: Colors.white)
                      : const FaIcon(FontAwesomeIcons.feather,
                          color: Colors.pinkAccent),
                  style: ElevatedButton.styleFrom(
                      foregroundColor:
                          quiz.done ? Colors.white : Colors.pinkAccent,
                      backgroundColor: quiz.done ? Colors.green : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {
                    if (!quiz.done) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzWidget(
                            quiz: quiz,
                            title: "Quizz",
                            userEmail: widget.userEmail ?? 'default',
                          ),
                        ),
                      );
                    }
                  },
                  label: Text(
                    '${quiz.description}${quiz.done ? ' (${quiz.score?.score ?? ''}/${quiz.score?.maxScore ?? ''})' : ''}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
