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
  bool isCheckboxValid = true;
  bool isUserEmailUnique = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/w.png"),
              fit: BoxFit.contain,
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
                decoration: !isUserEmailUnique || !isEmailValid
                    ? !isUserEmailUnique
                        ? const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                            errorText: 'Email has already been taken')
                        : const InputDecoration(
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
                FormField<bool>(
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: hasAcceptEmailSharing,
                                onChanged: (value) {
                                  setState(() {
//save checkbox value to variable that store terms and notify form that state changed
                                    hasAcceptEmailSharing = value ?? false;
                                    state.didChange(value);
                                  });
                                }),
                            GestureDetector(
                              onTap: () {
                                setState(() {
//save checkbox value to variable that store terms and notify form that state changed
                                  hasAcceptEmailSharing =
                                      !hasAcceptEmailSharing;
                                });
                              },
                              child: Text('I accept sharing this email',
                                  style: TextStyle(
                                    color: !isCheckboxValid
                                        ? Theme.of(context).colorScheme.error
                                        : const Color(0xFF000000),
                                  )),
                            ),
                          ],
                        ),
                        Text(
                          isCheckboxValid ? '' : 'You need to accept terms',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        )
                      ],
                    );
                  },
                )
              ]),
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isEmailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email ?? '');

                          isCheckboxValid = hasAcceptEmailSharing;
                        });

                        if (isEmailValid && isCheckboxValid) {
                          httpServices
                              .addUser(UserAddModel(
                                  firstName ?? '', lastName ?? '', email ?? ''))
                              .then((statusCode) {
                            setState(() {
//save checkbox value to variable that store terms and notify form that state changed
                              isUserEmailUnique = statusCode == 200;
                            });
                            if (isUserEmailUnique) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizzWidget(
                                        title: "Quizz",
                                        userEmail: email ?? 'default')),
                              );
                            }
                          });
                        }
                      },
                      child: const Text('Commencer')))
            ],
          ),
        ),
      ),
    );
  }
}
