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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  final HttpServices httpServices = HttpServices();
  HomePage({
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
  bool hasAcceptEmailSharing = false;
  bool isEmailValid = true;

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
                decoration: !isEmailValid
                    ? const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                        errorText: 'Email format is not valid')
                    : const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Email'),
                onChanged: (String? value) {
                  email = value;
                },
              ),
              Row(children: [
                Checkbox(
                    value: hasAcceptEmailSharing,
                    onChanged: (bool? value) {
                      setState(() {
                        hasAcceptEmailSharing = value ?? false;
                      });
                    }),
                const Text("I accept sharing this email")
              ]),
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                      onPressed: hasAcceptEmailSharing
                          ? () {
                              if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email ?? '')) {
                                setState(() {
                                  isEmailValid = true;
                                });
                                httpServices.addUser(UserAddModel(
                                    firstName ?? '',
                                    lastName ?? '',
                                    email ?? ''));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizzWidget(
                                          title: "Quizz",
                                          userEmail: email ?? 'default')),
                                );
                              } else {
                                setState(() {
                                  isEmailValid = false;
                                });
                              }
                            }
                          : null,
                      child: const Text('Commencer')))
            ],
          ),
        ),
      ),
    );
  }
}
