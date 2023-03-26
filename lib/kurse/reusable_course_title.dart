import 'package:de_zone/constants.dart';
import 'package:flutter/material.dart';

//Kurstitel verwendet in CoursesScreen für Titel GRUPPENKURSE, PRÜFUNGSVORBEREITUNG
class ReusableCourseTitle extends StatelessWidget {
  final String title;
  const ReusableCourseTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: kTitleTextStyleNormalSize18)),
    );
  }
}
