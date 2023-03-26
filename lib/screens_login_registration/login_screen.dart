import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:de_zone/screens_login_registration/reset_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable__widgets_generall.dart';
import '../bottom_navigation_bar.dart';
import '../screens_login_registration/sign_up_screen.dart';
import 'reusable_widgets_login_signup.dart';
import '../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //FormState um FormField zu speichern, zurückzusetzen und zu validieren
  final _formKey = GlobalKey<FormState>();
  //controller um auf die Inhalte zugreifen zu können
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;
  //String to display errors
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 45),
                      ReusableTitleWithText(
                          myTitle: 'Schön, dass du wieder hier bist!',
                          myText:
                              'Gebe deine E-Mail-Adresse ein, um dich bei deinem '
                              'Konto anzumelden.'),
                      reusableWidgetImage('images/login.png'),
                      reusableEmailTextFormField(
                          'E-Mail-Adresse eingeben', _emailController),
                      const SizedBox(height: 15),
                      reusablePasswordTextFormField('Passwort eingeben',
                          _passwordController, TextInputAction.done),
                      const SizedBox(height: 35),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen()));
                        },
                        child: const Text('Passwort vergessen?',
                            style: kBodyTextStyleBold14),
                      ),
                      const SizedBox(height: 20),
                      reusableBottomButton(context, 'ANMELDEN', () {
                        signIn(_emailController.text, _passwordController.text);
                      }),
                      const SizedBox(height: 15),
                      signUpOption(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login function
  void signIn(String email, String password) async {
    //only if validation is ok, execute this
    if (_formKey.currentState!.validate()) {
      try {
        final favoriteCoursePro =
            Provider.of<FavoriteCourseProvider>(context, listen: false);
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((res) {
          //user id lokal speichern
          SettingsCache.instance.setString('userId', res.user!.uid);
          favoriteCoursePro.retrieveCourses();
          Fluttertoast.showToast(msg: 'Erfolgreich angemeldet');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenBottomNavigationBar()));
          //catching error
        });
      } on FirebaseAuthException catch (error) {
        errorHandlingSwitchCase(error);
        Fluttertoast.showToast(msg: errorMessage!);
        //print(error.code);
      }
    }
  }

//Nachrichten, die angezeigt werden können
  errorHandlingSwitchCase(e) {
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'Eingegebene E-Mail ist ungültig';
        break;
      case 'wrong-password':
        errorMessage = 'Email oder Password wurde falsch eingegeben.';
        break;
      case 'user-not-found':
        errorMessage = 'Nutzer mit dieser E-Mail existiert nicht.';
        break;
      case 'user-disabled':
        errorMessage = 'Nutzer mit dieser E-Mail wurde deaktiviert.';
        break;
      case 'too-many-requests':
        errorMessage = 'Zu viel Anfragen gesendet.';
        break;
      case "operation-not-allowed":
        errorMessage =
            "Anmeldung mit dieser Email und Passwort nicht aktiviert.";
        break;
      default:
        errorMessage = "Ein anderer Fehler wurde verursacht.";
    }
  }

  Row signUpOption(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Du besitzt noch kein Konto? ', style: kBodyTextStyleNormal14),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: const Text('Konto anlegen', style: kBodyTextStyleBold14),
      )
    ]);
  }
}
