import 'package:de_zone/lerninhalt/uebungen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class LerninhaltScreen extends StatefulWidget {
  const LerninhaltScreen({Key? key}) : super(key: key);

  @override
  State<LerninhaltScreen> createState() => _LerninhaltScreenState();
}

class _LerninhaltScreenState extends State<LerninhaltScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          //left, top, right, bottom
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Damit dein Deutschabenteuer beginnen kann, wähle hier einen Bereich aus: ',
                style: kTitleTextStyleBoldSize22,
                textAlign: TextAlign.left,
              ),
              //
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kColourBlueMain,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage('images/german-flag.jpg')),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Deutsch',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: kColourWhiteNormal),
                    ),
                  ],
                ),
              ),

              ///Second Row with 2 Columns
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: reusableContainerCard(
                        context,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UebungenScreen(),
                              ));
                        },
                        'Übungen',
                      ),
                    ),
                    Expanded(
                      child: reusableContainerCard(
                        context,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UebungenScreen(),
                              ));
                        },
                        'Aussprache',
                      ),
                    ),
                  ],
                ),
              ),

              ///Third Row with 2 Columns
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: reusableContainerCard(
                        context,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UebungenScreen(),
                              ));
                        },
                        'Wortschatz',
                      ),
                    ),
                    Expanded(
                      child: reusableContainerCard(
                        context,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UebungenScreen(),
                              ));
                        },
                        'Grammatik',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //USABLE CONTAINER CARDS - EXERCISES, PRONUNCIATION, VOCABULARY, GRAMMAR
  Container reusableContainerCard(
      BuildContext context, Function() onTap, String title) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kColourGreyMain,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
              child: const CircleAvatar(
                radius: 22,
                backgroundColor: kColourPurpleMain,
                child: Center(
                  child: Icon(
                    Icons.play_arrow_outlined,
                    color: kColourBlueMain,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: kTitleTextStyleBoldSize18,
            ),
            const Text(
              'Dein Fortschritt',
              style: kBodyTextStyleNormal16,
            ),
          ],
        ),
      ),
    );
  }
} //end of class _HomeScreenState
