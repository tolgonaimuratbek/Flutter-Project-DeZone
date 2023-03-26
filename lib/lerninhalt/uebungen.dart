import 'package:flutter/material.dart';

class UebungenScreen extends StatefulWidget {
  @override
  State<UebungenScreen> createState() => _UebungenScreenState();
}

class _UebungenScreenState extends State<UebungenScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text('Übungen'),
      ),
    );
  }
}
