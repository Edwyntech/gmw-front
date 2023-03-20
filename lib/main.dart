import 'package:flutter/material.dart';
import 'package:guess_my_w/services/http_services.dart';
import 'package:guess_my_w/widgets/quizz.widget.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePage> {
  final HttpServices httpServices = HttpServices();
   String? userName = "test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/w.jpeg"),
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter),
        ),
        margin: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Saisir votre nom',
                ),
                onChanged: (String? value) {
                  userName = value;
                },
              ),
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                      onPressed: () {
                        httpServices.addUserName(userName ?? 'default');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizzWidget(title: "Quizz", userName: userName ?? 'default')),
                        );
                      },
                      child: const Text('Commencer')))
            ],
          ),
        ),
      ),
    );
  }
}
