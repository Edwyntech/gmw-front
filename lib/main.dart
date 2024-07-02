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
        colorSchemeSeed: Colors.pinkAccent,
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final HttpServices httpServices = HttpServices();

  HomePage({Key? key}) : super(key: key);

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
  bool firstValidation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: NetworkImage("assets/assets/images/w1.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        margin: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFirstNameTextField(),
              buildLastNameTextField(),
              buildEmailTextField(),
              buildAcceptEmailSharingCheckbox(),
              buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        labelText: 'Prénom',
      ),
      onChanged: (value) {
        setState(() {
          firstName = value;
        });
      },
    );
  }

  Widget buildLastNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        labelText: 'Nom',
      ),
      onChanged: (value) {
        setState(() {
          lastName = value;
        });
      },
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        labelText: 'Email',
        errorText: isEmailValid ? null : 'Email format is not valid',
      ),
      onChanged: (value) {
        setState(() {
          firstValidation = false;
          email = value;
          isEmailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email ?? '');
        });
      },
    );
  }

  Widget buildAcceptEmailSharingCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FormField<bool>(
              builder: (state) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      value: hasAcceptEmailSharing,
                      onChanged: (value) {
                        setState(() {
                          hasAcceptEmailSharing = value ?? false;
                          isCheckboxValid = hasAcceptEmailSharing;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hasAcceptEmailSharing = !hasAcceptEmailSharing;
                          isCheckboxValid = hasAcceptEmailSharing;
                        });
                      },
                      child: Text(
                        'I accept sharing this email',
                        style: TextStyle(
                          color: isCheckboxValid
                              ? Theme.of(context).textTheme.bodyMedium?.color
                              : Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        if (!isCheckboxValid)
          Text(
            'You need to accept terms',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  Widget buildStartButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ElevatedButton.icon(
        onPressed: !firstValidation && isEmailValid && isCheckboxValid ? startButtonPressed : null,
        icon: const FaIcon(FontAwesomeIcons.circlePlay,
            color: Colors.pinkAccent),
        label: const Text('Commencer'),
      ),
    );
  }

  void startButtonPressed() {
    httpServices
        .addUser(UserAddModel(
            firstName: firstName ?? '',
            lastName: lastName ?? '',
            email: email ?? ''))
        .then((statusCode) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuizChoiceWidget(userEmail: email ?? 'default')),
      );
    });
  }
}
