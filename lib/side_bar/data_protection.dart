import 'package:de_zone/side_bar/unordered_list_item.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../constants.dart';

class DataProtectionScreen extends StatelessWidget {
  const DataProtectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 10, bottom: 50, top: 10, left: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Datenschutzrichtlinie',
                          textAlign: TextAlign.left,
                          style: kTitleTextStyleBoldSize22,
                        ),
                      ),
                      const Text(
                        'Wir nehmen den Schutz Ihrer Daten sehr ernst, und wir haben uns dazu verpflichtet, Ihre Privatsphäre zu schützen. In dieser Datenschutzrichtlinie erläutern wir unsere Verfahren bezüglich der Erfassung, Verwendung und Offenlegung von Daten. ',
                        style: kBodyTextStyleNormal16,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Diese Richtlinie umfasst:',
                        style: kTitleTextStyleBoldSize18,
                      ),
                      UnorderedListItem(
                          'die personenbezogenen Daten, die wir sammeln'), //2
                      UnorderedListItem(
                          'wie und warum wir Ihre personenbezogenen Daten sammeln und verwenden'), //3
                      UnorderedListItem(
                          'warum wir Ihre personenbezogenen Daten verarbeiten'), //4
                      UnorderedListItem(
                          'die Maßnahmen, die wir ergreifen, um Ihre Daten sicher und vertraulich zu behandeln'), //9
                      UnorderedListItem('Ihre Rechtsansprüche '), //11
                      const SizedBox(height: 10),
                      InfoList(
                          'INFORMATIONEN, DIE WIR SAMMELN UND ERHALTEN'), //2
                      InfoList('NUTZUNG VON INFORMATIONEN'), //3
                      InfoList(
                          'SPEICHERUNG UND WEITERGABE IHRER PERSÖNLICHEN DATEN'), //4
                      InfoList('VERTRAULICHKEIT UND SICHERHEIT'), //9
                      InfoList('IHRE RECHTSANSPRÜCHE'), //11
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoList extends StatelessWidget {
  final String text1;
  InfoList(this.text1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          text1,
          style: kTitleTextStyleBoldSize18,
        ),
        const Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          style: kBodyTextStyleNormal16,
        ),
      ],
    );
  }
}
