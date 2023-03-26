import 'package:flutter/material.dart';

//Runder Fortschrittsindikator - aufgerufen in Chat (beim Klicken auf einen Empfänger), CoursesScreen (beim Laden der Kursdaten), NavigationsBar (beim Laden)
Widget circular() {
  return const Center(
    child: CircularProgressIndicator(
      strokeWidth: 5,
    ),
  );
}
