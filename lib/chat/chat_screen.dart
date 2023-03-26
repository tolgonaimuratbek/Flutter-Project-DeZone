import 'package:de_zone/model/message_model.dart';
import 'package:de_zone/providers/message_provider.dart';
import 'package:de_zone/common/widgets/circular.dart';
import 'package:de_zone/model/user_auth_model.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../constants.dart';

//wird in der Kontaktlisteseite aufgerufen
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  UserModel? user;
  String val = '';

  //controller um auf die Inhalte zugreifen zu können
  final ScrollController _controller = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //Nachricht StreamBuilder - an Empfänger in Echtzeit eine Nachricht senden kann, Änderung in Nachricht
  buildMessage(UserProvider userProvider, MessageProvider messageProvider) {
    return StreamBuilder(
        //ruft Funktion messagesRef auf
        stream: messagesRef
            .doc(messageProvider.setMessageIdBetweenUsers(
                userProvider.currentUser!.uid!, userProvider.partner!.uid!))
            .collection("userMessages")
            //descending: true (absteigend) Nachrichten werden aufsteigend angezeigt
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circular();
          }
          List<MessageModel> messages = [];
          for (var doc in snapshot.data!.docs) {
            messages.add(MessageModel.fromJson(doc.data()));
          }
          return ListView.builder(
              controller: _controller,
              itemCount: messages.length,
              itemBuilder: (ctx, i) {
                var message = messages[i];
                bool me = userProvider.currentUser!.uid! == message.from;

                return buildMessageContainer(context, message, me);
              });
        });
  }

//Nachricht Austausch zw zwei Partner - Absender und Empfänger Daten
  sendMessage(UserProvider userProvider, MessageProvider messageProvider) {
    messageProvider.addNewMessage(
        userProvider.currentUser!,
        userProvider.partner!,
        //MessageModel mit AbsenderId, EmpfängerId, Absendername, Nachricht, Nachrichtart, Uhrzeit
        MessageModel(
            from: userProvider.currentUser!.uid!,
            to: userProvider.partner!.uid,
            senderName: userProvider.currentUser!.userName,
            message: messageController.text,
            type: 'message',
            timestamp: DateTime.now().toString()));
    messageController.clear();
  }

  //Chat Seite für den Austausch von Nachrichten zw zwei Partner
  @override
  Widget build(BuildContext context) {
    final msgProvider = Provider.of<MessageProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              //Bild vor dem Name
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: kColourGreyMain,
                  child: Image.network(
                    personImageLink,
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              //widget zum Klicken
              InkWell(
                onTap: () {
                  //Empfängername noch nicht klickbar
                },
                //Name des Empfängers
                child: Text(
                  userProvider.partner!.userName!,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                  child: Container(
                      height: 800,
                      child: buildMessage(userProvider, msgProvider))),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      //Textfeld für die Erfassung von Nachrichten
                      child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          labelText: "Nachricht tippen",
                        ),
                        onSubmitted: (String value) {
                          if (value.isNotEmpty) {
                            sendMessage(userProvider, msgProvider);
                          }
                        },
                        onChanged: (String value) {
                          setState(() {
                            val = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    messageController.text.isEmpty
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () {
                              //beim Senden Funktion aufrufen
                              sendMessage(userProvider, msgProvider);
                              // _scrollDown();
                            },
                            child: const Icon(Icons.send,
                                color: kColourPurpleMain))
                  ],
                ),
              )
            ],
          ),
        ));
  }

//Nachrichten, die angezeigt werden
  Column buildMessageContainer(
      BuildContext context, MessageModel messageDto, bool me) {
    return Column(
      crossAxisAlignment:
          //msg order
          me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          color: me ? kColourPurpleMain : kColourGreyMain,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: 240,
            child: Column(
              children: [
                //Nachricht der beiden Partner
                Text(
                  messageDto.message!, //Nachrichttext
                  style: TextStyle(color: kColourBlueMain),
                ),
                Text(
                    timeago.format(
                        DateTime.parse(
                            messageDto.timestamp!), //Uhrzeit der Nachricht
                        locale: 'de'),
                    style: TextStyle(color: kColourYellowMain, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
