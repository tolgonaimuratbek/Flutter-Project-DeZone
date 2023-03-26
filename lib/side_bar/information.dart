import 'package:de_zone/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:de_zone/side_bar/unordered_list_item.dart';
import '../constants.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

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
                          child: Text('Impressum',
                              style: kTitleTextStyleBoldSize18)),
                      const SizedBox(height: 10),
                      UnorderedListItem(
                          'DeZone GmbH, Erdgeschoss, 69785 Musterstadt, Deutschland'),
                      const SizedBox(height: 10),
                      UnorderedListItem(
                          'Firmenvertreter: Musterfrau Mustermann '),
                      const SizedBox(height: 10),
                      UnorderedListItem('Telefon: 0049 00 0000 0000'),
                      const SizedBox(height: 10),
                      UnorderedListItem('E-Mail: beispiel@gmail.com'),
                      const SizedBox(height: 10),
                      UnorderedListItem(
                          'Handelsregister: Beispiel Handelsregister'),
                      const SizedBox(height: 10),
                      UnorderedListItem(
                          'Umsatzsteueridentifikationsnummer: DE000000000')
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
