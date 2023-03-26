import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_zone/constants.dart';
import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/model/user_auth_model.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens_login_registration/login_screen.dart';
import 'account.dart';
import 'data_protection.dart';
import 'information.dart';
import 'notification.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: DelayedDisplay(
            slidingCurve: Curves.easeInCirc,
            slidingBeginOffset: const Offset(0.0, 0.35),
            child: Material(
                //color: kColourPurpleMain,
                //textStyle: TextStyle(),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 60, 24, 0),
                    child: ListView(children: [
                      headerWidget(userProvider.currentUser!),
                      const SizedBox(height: 30),
                      const Divider(
                          thickness: 1, height: 10, color: kColourPurpleMain),
                      const SizedBox(height: 30),
                      reusableListTile(
                          Icons.person_outline,
                          const Text('Account'),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountScreen()))),
                      reusableListTile(
                          Icons.notifications_outlined,
                          const Text('Benachrichtigung'),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()))),
                      reusableListTile(
                          Icons.privacy_tip_outlined,
                          const Text('Information'),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InformationScreen()))),
                      reusableListTile(
                          Icons.folder_copy_outlined,
                          const Text('Datenschutz'),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DataProtectionScreen()))),
                      reusableListTile(Icons.share_outlined,
                          const Text('App mit Freunden teilen'), () => null),
                      //LOG OUT
                      const SizedBox(height: 30),
                      const Divider(
                          thickness: 1, height: 10, color: kColourPurpleMain),
                      const SizedBox(height: 30),
                      reusableListTile(
                          Icons.logout_outlined, const Text('Abmelden'), () {
                        SettingsCache.instance.removeValue('userId');

                        logout(context);
                      })
                    ])))));
  }

  //header widget
  Widget headerWidget(UserModel loggedInUser) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(personImageLink),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //In Seitenbar Name anzeigen
            Text(loggedInUser.userName ?? 'Kein Name eingefügt',
                style: const TextStyle(color: kColourBlueMain)),
            const SizedBox(height: 10),
            //In Seitenbar Email anzeigen
            Text('${loggedInUser.email}',
                style: const TextStyle(color: kColourBlueMain)),
          ],
        )
      ],
    );
  }

  //method reusableListTile
  ListTile reusableListTile(IconData icon1, Widget text, Function() onTap) {
    return ListTile(
      textColor: kColourBlueMain,
      title: text,
      leading: Icon(
        icon1,
        color: kColourBlueMain,
      ),
      onTap: onTap,
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
} //END OF CLASS SideBar
