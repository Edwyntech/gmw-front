import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/models/quizz.model.dart';
import 'package:guess_my_w/services/http_services.dart';
import 'package:guess_my_w/widgets/question.widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpServices httpServices = HttpServices();

  List<Quizz>? quizzList;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: httpServices.getQuizzList(),
      builder: (context, AsyncSnapshot<List<Quizz>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          quizzList = snapshot.data;
          return Scaffold(
              body: Column(
            children: [
              QuestionWidget(quizz: quizzList![0]),
            ],
          ));
        } else {
          return Text('Loading ...');
        }
      });
}
