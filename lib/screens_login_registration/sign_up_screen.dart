import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/model/user_auth_model.dart';
import 'package:de_zone/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'reusable_widgets_login_signup.dart';
import '../constants.dart';
import '../components/reusable__widgets_generall.dart';
import '../screens_login_registration/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  //Ein FormState kann verwendet werden, um jedes FormField zu speichern, zurückzusetzen und zu validieren
  final _formKey = GlobalKey<FormState>();
  //controller, um auf die Inhalte zugreifen zu können
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
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
                  children: [
                    const SizedBox(height: 45),
                    ReusableTitleWithText(
                        myTitle: 'Konto anlegen ',
                        myText:
                            'Nachdem du dir ein Konto angelegt hast, kann schon dein Deutschabenteuer beginnen.'),
                    const SizedBox(height: 65),
                    reusableUserNameTextFormField('Name', _userNameController),
                    const SizedBox(height: 15),
                    reusableEmailTextFormField(
                        'E-Mail-Adresse eingeben', _emailController),
                    const SizedBox(height: 15),
                    reusablePasswordTextFormField('Passwort eingeben',
                        _passwordController, TextInputAction.next),
                    const SizedBox(height: 15),
                    reusableConfirmedPasswordTextFormField(
                        'Passwort bestätigen',
                        _passwordController,
                        _confirmedPasswordController),
                    const SizedBox(height: 45),
                    reusableBottomButton(context, 'KONTO ANLEGEN', () {
                      signUp(_emailController.text, _passwordController.text);
                    }),
                    const SizedBox(height: 15),
                    signUpOption(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //signUp Funktion
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  //dann senden Werte an den Firestore
                  postDetailsToFirestor(),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.toString());
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
        errorMessage = '';
        break;
      case 'wrong-password':
        errorMessage = 'Password wurde falsch eingegeben.';
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

  postDetailsToFirestor() async {
    //FireStore aufrufen
    //den UserModel aufrufen
    //Werten senden
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //alle Werte schreiben
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = _userNameController.text;

    //geht auf Sammlung (collection), erstellt Nutzer Sammlung (collection user)
    //da wird DokumentId hinzugefügt
    //map aufrufen, um daten zu senden
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    SettingsCache.instance.setString('userId', user.uid);
    Fluttertoast.showToast(msg: 'Account erfolgreich erstellt');

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ScreenBottomNavigationBar()),
        (route) => false);
  }

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hast du bereits ein Konto? ',
            style: kBodyTextStyleNormal14),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Anmelden', style: kBodyTextStyleBold14),
        ),
      ],
    );
  }
}
