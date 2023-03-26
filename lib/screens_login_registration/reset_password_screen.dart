import 'package:de_zone/screens_login_registration/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'reusable_widgets_login_signup.dart';
import '../constants.dart';
import '../components/reusable__widgets_generall.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //Ein FormState kann verwendet werden, um jedes FormField zu speichern, zurückzusetzen
  // und zu validieren
  final _formKey = GlobalKey<FormState>();
  ////controller um auf die Inhalte zugreifen zu können
  final TextEditingController _emailTextController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      myTitle: 'Neues Passwort erstellen',
                      myText:
                          'Gebe deine E-Mail-Adresse ein, um Passwort zurückzusetzen.',
                    ),
                    reusableWidgetImage('images/forgotPassword.png'),
                    reusableEmailTextFormField(
                        'E-Mail-Adresse eingeben', _emailTextController),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: const Text(
                        'Zurück zur Anmeldeseite',
                        style: kBodyTextStyleBold14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    reusableBottomButton(context, 'Password zurücksetzen', () {
                      resetPassword(_emailTextController.text);
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword(String email) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: email).then((value) {
          Fluttertoast.showToast(
              msg: 'Prüfe deine Email um dein Passwort zurückzusetzen');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } on FirebaseAuthException catch (error) {
        Fluttertoast.showToast(msg: error.message.toString());
      }
    }
  }
}
