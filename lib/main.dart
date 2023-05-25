import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guess_my_w/models/user-add.model.dart';
import 'package:guess_my_w/services/http_services.dart';
import 'package:guess_my_w/widgets/quiz.choice.widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GMW',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
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
              opacity: 0.3,
              image: NetworkImage("assets/assets/images/w.png"),
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
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  labelText: 'Prénom',
                ),
                onChanged: (String? value) {
                  firstName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  labelText: 'Nom',
                ),
                onChanged: (String? value) {
                  lastName = value;
                },
              ),
              TextFormField(
                decoration: !isEmailValid
                    ? const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                        ),
                        labelText: 'Email',
                        errorText: 'Email format is not valid')
                    : const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                        ),
                        labelText: 'Email'),
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
                  child: ElevatedButton.icon(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizChoiceWidget(
                                      userEmail: email ?? 'default')),
                            );
                          });
                        }
                      },
                      icon: const FaIcon(FontAwesomeIcons.circlePlay,
                          color: Colors.deepOrangeAccent),
                      label: const Text('Commencer')))
            ],
          ),
        ),
      ),
    );
  }
}
