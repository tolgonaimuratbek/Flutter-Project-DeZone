import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

//Emailtextfeld - verwendet in SignUpScreen
TextFormField reusableUserNameTextFormField(
    String text, TextEditingController controller) {
  return TextFormField(
    autofocus: false,
    controller: controller,
    keyboardType: TextInputType.name,
    validator: (value) {
      //reg expression for userName validation
      //validation for entering the nr of characters
      //min 6 requires firebase
      RegExp regExp = RegExp(r'^.{3,}$');
      if (value!.isEmpty) {
        return 'Name darf nicht leer sein';
      }
      if (!regExp.hasMatch(value)) {
        return ('Bitte einen gültigen Namen eingeben (3 Zeichen).');
      }
      return null;
    },
    //vom Benutzer eingegebenen Wert zu speichern - onSaved
    onSaved: (value) {
      controller.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_outline, color: kColourBlueMain),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: text,
        labelStyle: const TextStyle(color: kColourBlueMain),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
  );
}

//Emailtextfeld - verwendet in LoginScreen, SignUpScreen, ResetPasswordScreen, AccountScreen
TextFormField reusableEmailTextFormField(
    String text, TextEditingController controller) {
  return TextFormField(
    autofocus: false,
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      //Wenn Emailtextfeld ist leer, zurückgegeben "E-Mail Feld darf nicht leer sein"
      if (value!.isEmpty) {
        return 'E-Mail Feld darf nicht leer sein';
      }
      //Validierung für Email
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return ('Bitte eine gültige E-Mail eingeben');
      }
      return null;
    },
    //vom Benutzer eingegebenen Wert zu speichern - onSaved
    onSaved: (value) {
      controller.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail_outline, color: kColourBlueMain),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: text,
        labelStyle: const TextStyle(color: kColourBlueMain),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
  );
}

//Passworttextfeld verwendet in LoginScreen, SignUpScreen, AccountScreen
TextFormField reusablePasswordTextFormField(
    String text, TextEditingController controller, TextInputAction nextOrDone) {
  return TextFormField(
    autofocus: false,
    controller: controller,
    //obscureText means hide text
    obscureText: true,
    validator: (value) {
      //Validierung für Passwort
      //min 6 Zeichen firebase
      RegExp regExp = RegExp(r'^.{6,}$');
      if (value!.isEmpty) {
        return 'Passwort Feld darf nicht leer sein';
      }
      if (!regExp.hasMatch(value)) {
        return ('Password muss mehr als 6 Zeichen lang sein');
      }
    },
    //vom Benutzer eingegebenen Wert zu speichern - onSaved
    onSaved: (value) {
      controller.text = value!;
    },
    textInputAction: nextOrDone,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.lock_outline, color: kColourBlueMain),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      labelText: text,
      labelStyle: const TextStyle(color: kColourBlueMain),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

//Textfeld zur Bestätigung von Passwort verwendet in SignUpScreen
TextFormField reusableConfirmedPasswordTextFormField(
    String text,
    TextEditingController pwController,
    TextEditingController confirmedPwController) {
  return TextFormField(
    autofocus: false,
    controller: confirmedPwController,
    //obscureText = hide
    obscureText: true,
    validator: (value) {
      if (confirmedPwController.text != pwController.text) {
        return ('Beide Passwörter müssen gleich sein');
      }
      return null;
    },
    //vom Benutzer eingegebenen Wert zu speichern - onSaved
    onSaved: (value) {
      confirmedPwController.text = value!;
    },
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.lock_outline, color: kColourBlueMain),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      labelText: text,
      labelStyle: const TextStyle(color: kColourBlueMain),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
