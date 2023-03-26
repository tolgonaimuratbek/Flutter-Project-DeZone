//after login in, user first sees the splash screen for few seconds then user automatically get redirected to home page
//it will contain image logo & name; needs to be called in login - SplashScreen.routName

import 'dart:async';
import 'package:de_zone/screens_welcome/page_selector.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              //WelcomeLearn
              builder: (context) => PageSelector(),
            )));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              image: AssetImage('images/deZone-Logo.png'),
              width: 250.0,
              height: 250.0,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            //color: kColourBlackNormal,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Willkommen bei DeZone',
              style:
                  kTitleTextStyleBoldSize22.copyWith(color: kColourBlackNormal),
            ),
          ),
        ],
      ),
    );
  }
}
