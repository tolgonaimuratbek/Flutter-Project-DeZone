import 'package:flutter/material.dart';

import '../constants.dart';

//Gestaltung der Push-Benachrichtigungsseite
//verwendet in NotificationScreen

class NotificationBadge extends StatelessWidget {
  final int totalNotification;

  NotificationBadge({required this.totalNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: kColourPurpleMain,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text('$totalNotification', style: kTitleTextStyleBoldSize18),
        ),
      ),
    );
  }
}
