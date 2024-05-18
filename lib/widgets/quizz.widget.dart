import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/main.dart';
import 'package:guess_my_w/models/quiz.model.dart';
import 'package:guess_my_w/widgets/question.widget.dart';
import 'package:guess_my_w/widgets/quiz.choice.widget.dart';
import 'package:guess_my_w/widgets/score.widget.dart';

import '../models/question.with.answers.model.dart';

class QuizzWidget extends StatefulWidget {
  const QuizzWidget({
    Key? key,
    required this.title,
    required this.userEmail,
    required this.quiz,
  }) : super(key: key);

  final String title;
  final String userEmail;
  final Quiz quiz;

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  Timer? _timer;

  int _remainingMinutes = 15;
  int _remainingSeconds = 0;
  late int questionCounter = 0;
  late QuestionWithAnswers currentQuestion =
      widget.quiz.questionWithAnswers[questionCounter];
  bool hasBeenValidated = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          if (_remainingMinutes > 0) {
            _remainingMinutes--;
            _remainingSeconds = 59;
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuizChoiceWidget(userEmail: widget.userEmail),
              ),
            );
            _timer?.cancel();
          }
        }
      });
    });
  }

  void onVerifyAnswer(bool isValidated) {
    setState(() {
      hasBeenValidated = isValidated;
    });
  }

  void navigateToNextQuestionOrScore() {
    setState(() {
      if (++questionCounter < widget.quiz.questionWithAnswers.length) {
        currentQuestion = widget.quiz.questionWithAnswers[questionCounter];
        hasBeenValidated = false;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreWidget(
              quizId: widget.quiz.id,
              userEmail: widget.userEmail,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.list),
          tooltip: 'Quiz selection',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuizChoiceWidget(userEmail: widget.userEmail),
              ),
            );
          },
        ),
        title: Text(
            '$_remainingMinutes:${_remainingSeconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 12) // Change the font size here
            ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () {
              _timer?.cancel();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: QuestionWidget(
              quizz: currentQuestion,
              onVerifyAnswer: onVerifyAnswer,
              hasBeenValidated: hasBeenValidated,
              userEmail: widget.userEmail,
            ),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleChevronRight),
            color: Colors.deepOrangeAccent,
            onPressed: hasBeenValidated ? navigateToNextQuestionOrScore : null,
          ),
        ],
      ),
    );
  }
}
