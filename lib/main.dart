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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.3,
              image: NetworkImage("assets/assets/images/w1.png"),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Edwyn Quiz',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          buildFirstNameTextField(),
                          const SizedBox(height: 20),
                          buildLastNameTextField(),
                          const SizedBox(height: 20),
                          buildEmailTextField(),
                          const SizedBox(height: 20),
                          buildAcceptEmailSharingCheckbox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildStartButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, void Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        labelText: label,
        labelStyle: TextStyle(color: Colors.pinkAccent),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      style: TextStyle(color: Colors.black87),
      onChanged: onChanged,
    );
  }
  Widget buildFirstNameTextField() {
    return buildTextField('Prénom', (value) => setState(() => firstName = value));
  }

  Widget buildLastNameTextField() {
    return buildTextField('Nom', (value) => setState(() => lastName = value));
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.pinkAccent),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorText: isEmailValid ? null : 'Email format is not valid',
        errorStyle: TextStyle(color: Colors.red),
      ),
      style: TextStyle(color: Colors.black87),
      onChanged: (value) {
        setState(() {
          firstValidation = false;
          email = value;
          isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email ?? '');
        });
      },
    );
  }
  Widget buildAcceptEmailSharingCheckbox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          hasAcceptEmailSharing = !hasAcceptEmailSharing;
          isCheckboxValid = hasAcceptEmailSharing;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: hasAcceptEmailSharing,
            onChanged: (value) {
              setState(() {
                hasAcceptEmailSharing = value ?? false;
                isCheckboxValid = hasAcceptEmailSharing;
              });
            },
          ),
          const SizedBox(width: 10),
          Text(
            'I accept sharing this email',
            style: TextStyle(
              color: isCheckboxValid ? Theme.of(context).textTheme.bodyMedium?.color : Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStartButton() {
    return ElevatedButton.icon(
      onPressed: !firstValidation && isEmailValid && hasAcceptEmailSharing ? startButtonPressed : null,
      icon: const FaIcon(FontAwesomeIcons.circlePlay, color: Colors.white),
      label: const Text('Commencer', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
