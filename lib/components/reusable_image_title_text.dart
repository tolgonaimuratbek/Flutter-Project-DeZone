import 'package:flutter/material.dart';

//wiederverwendbarer Widget mit Text, Title, Körpertext
//verwendet in den drei Einführungsseiten
class WelcomeImageTitleText extends StatelessWidget {
  final AssetImage myImage;
  final String myTitle;
  final String myText;

  WelcomeImageTitleText(
      {required this.myImage, required this.myTitle, required this.myText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          alignment: Alignment.topCenter,
          image: myImage,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
        ),
        const SizedBox(height: 12.0),
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
