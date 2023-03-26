import 'package:de_zone/chat/chat_screen.dart';
import 'package:de_zone/constants.dart';
import 'package:de_zone/kurse/app_router.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Kontaktlisteseite wird in der Nagivationsseite statt Chat aufgerufen
class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0), //top
            child: Text('Nutzerliste', style: kTitleTextStyleBoldSize22),
          ),
        ),
        Expanded(
          child: ListView.separated(
              //Separator zwischen den Nutzern in der Kontaktliste
              separatorBuilder: (ctx, i) {
                return const Divider(
                  endIndent: 30,
                  color: kColourBlueMain,
                );
              },
              itemCount: userProvider.listAllUsers.length,
              itemBuilder: (ctx, i) {
                var user = userProvider.listAllUsers[i];
                return GestureDetector(
                  onTap: () {
                    userProvider.setPatner(user);
                    AppRouter.routeTo(context, Chat());
                  },
                  child: ListTile(
                    title: Text(user.userName!), //change username color
                    leading: Image.network(personImageLink),
                  ),
                );
              }),
        ),
      ],
    ));
  }
}
