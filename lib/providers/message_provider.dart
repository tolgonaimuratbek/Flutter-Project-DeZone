import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_zone/model/user_auth_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/message_model.dart';

//Diskussion zwischen den Partnern
final messagesRef = FirebaseFirestore.instance
    .collection('messages')
    .withConverter<MessageModel>(
      fromFirestore: (snapshots, _) => MessageModel.fromJson(snapshots.data()!),
      toFirestore: (msg, _) => msg.toJson(),
    );

//verwendet in Chat
class MessageProvider extends ChangeNotifier {
  String setMessageIdBetweenUsers(String from, String to) {
    String resultat = "";
    List<String> list = [from, to];
    list.sort((a, b) => a.compareTo(b));
    for (var x in list) {
      resultat += x + "+";
    }
    return resultat;
  }

  //Nachricht senden von aktuellem Nutzer zum Empfänger verwendet in Chat
  void addNewMessage(
      UserModel sender, UserModel receiver, MessageModel message) {
    messagesRef
        .doc(setMessageIdBetweenUsers(sender.uid!, receiver.uid!))
        .collection("userMessages")
        .add(message.toJson());
  }
}
