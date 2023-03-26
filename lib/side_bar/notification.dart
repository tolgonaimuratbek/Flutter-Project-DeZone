import 'notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constants.dart';
import '../model/push_notification_model.dart';
//in main return OverlaySupport.global( child: MaterialApp(...

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //Initialisierung von Werten
  late final FirebaseMessaging _messaging;
  //Zähler, der die Benachrichtigung zählt
  late int _totalNotificationCounter;
  //Model für Push-Benachrichtigung mit title, body, dataTitle, dataBody
  PushNotificationModel? _notificationInfo;

  //Registerbenachrichtigung
  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;
    //Benachrichtigungseinstellungen - Erlaubnis anfordern
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    //Prüfen, ob der Benutzer eine bestimmte Benachrichtigung für die Anwendung zugelassen hat oder nicht
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      //Hauptnachricht
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //Speichern der Nachricht in der Push-Benachrichtigung
        PushNotificationModel notification = PushNotificationModel(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        //Erhöhen des Benachrichtigungszählers, Speichern des Benachrichtigungswertes in der Benachrichtigungsinfo
        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });
        if (notification != null) {
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading:
                NotificationBadge(totalNotification: _totalNotificationCounter),
            subtitle: Text(_notificationInfo!.body!),
            background: kColourYellowMain,
            duration: Duration(seconds: 5),
          );
        }
      });
    } else {
      print('Erlaubnis vom Benutzer abgelehnt');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationModel notification = PushNotificationModel(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      //Erhöhen des Benachrichtigungszählers, Speichern des Benachrichtigungswertes in der Benachrichtigungsinfo
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    //wenn die Anwendung im Hintergrund läuft
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotificationModel notification = PushNotificationModel(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      //Erhöhen des Benachrichtigungszählers, Speichern des Benachrichtigungswertes in der Benachrichtigungsinfo
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    });
    //normale Benachrichtigung
    registerNotification();
    //wenn die Anwendung beendet wird
    checkForInitialMessage();
    //Zähler
    _totalNotificationCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benachrichtigung')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Benachrichtigungen',
              textAlign: TextAlign.center,
              style: kTitleTextStyleBoldSize18,
            ),
            const SizedBox(height: 12),
            ////Benachrichtigung badge anzeigen, die die Gesamtzahl der eingegangenen Benachrichtigungen zählt
            NotificationBadge(totalNotification: _totalNotificationCounter),
            const SizedBox(height: 50),
            //Anzeigen, wenn nur nicht null; sonst leerer Container
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          '${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                          style: kBodyTextStyleBold14),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        '${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                        style: kBodyTextStyleNormal14.copyWith(
                            color: kColourYellowMain),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
