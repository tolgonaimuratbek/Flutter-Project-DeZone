import 'package:flutter/material.dart';
import '../constants.dart';

//Bild Widget - verwendet in LoginScreen, ResetPasswordScreen
Image reusableWidgetImage(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 180,
    height: 180,
  );
}

//wiederverwendbare Schaltfläche verwendet in PageSelector (Los gehts), LoginScreen (ANMELDEN),
// SignUpScreen(KONTO ANLEGEN), ResetPasswordScreen(Password zurücksetzen), AccountScreen (Passwort ändern)
Material reusableBottomButton(
    BuildContext context, String buttonText, Function onPress) {
  return Material(
    elevation: 5,
    color: kColourBlueMain,
    child: MaterialButton(
      //left, top, right, bottom
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        onPress();
      },
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: kColourYellowMain),
      ),
    ),
  );
}

//wiederverwendbarer Texttitel verwendet in
// LoginScreen, SignUpScreen, ResetPasswordScreen, AccountScreen
class ReusableTitleWithText extends StatelessWidget {
  final String myTitle;
  final String myText;

  ReusableTitleWithText({required this.myTitle, required this.myText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          myTitle,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8.0),
        Text(
          myText,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
