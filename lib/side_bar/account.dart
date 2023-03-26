import 'package:de_zone/app_bar.dart';
import 'package:de_zone/components/reusable__widgets_generall.dart';
import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/kurse/app_router.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:de_zone/screens_login_registration/login_screen.dart';
import 'package:de_zone/screens_login_registration/reusable_widgets_login_signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

//email und password ändern dafür altes password eingeben
class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ReusableTitleWithText(
                  myTitle: 'Deine Account ändern',
                  myText: 'Gebe deine E-Mail-Adresse, altest und neues Psswort '
                      'ein, um dein Passwort zu ändern',
                ),
                SizedBox(height: 20),
                reusableEmailTextFormField(
                  'Aktuelle E-Mail eingeben',
                  _emailController,
                ),
                const SizedBox(height: 15),
                reusablePasswordTextFormField('Altes Passwort eingeben',
                    _oldPasswordController, TextInputAction.next),
                const SizedBox(height: 15),
                reusablePasswordTextFormField('Neues Passwort eingeben',
                    _passwordController, TextInputAction.done),
                const SizedBox(height: 15),
                reusableBottomButton(
                  context,
                  'Passwort ändern',
                  () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        bool? res = await userProvider.editEmail(
                            _oldPasswordController.text,
                            _emailController.text,
                            _passwordController.text);

                        if (res == true) {
                          SettingsCache.instance.removeValue('userId');
                          AppRouter.routeTo(context, LoginScreen());
                          Fluttertoast.showToast(msg: 'Daten wurden geändert');
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  'Konto nicht gefunden , Bitte die eingegebenen Daten prüfen!');
                        }
                      } on Exception catch (error) {
                        Fluttertoast.showToast(msg: error.toString());
                        //print(error.code);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
