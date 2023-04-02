import 'package:flutter/material.dart';
import 'package:guess_my_w/models/user-add.model.dart';
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
   String? firstName = "testFirstName";
   String? lastName = "testLastName";
   String? email = "testEmail";

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
                  labelText: 'Prénom',
                ),
                onChanged: (String? value) {
                  firstName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nom',
                ),
                onChanged: (String? value) {
                  lastName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (String? value) {
                  email = value;
                },
              ),
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                      onPressed: () {
                        httpServices.addUser(new UserAddModel(firstName ?? '',
                            lastName ?? '',
                            email ?? ''));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizzWidget(title: "Quizz", userEmail: email ?? 'default')),
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
