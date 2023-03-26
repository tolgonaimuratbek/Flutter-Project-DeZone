import 'package:flutter/material.dart';

import '../constants.dart';

class UnorderedListItem extends StatelessWidget {
  final String text;
  UnorderedListItem(this.text);

  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '• ',
          style: kBodyTextStyleNormal16,
        ),
        Expanded(
            child: Text(
          text,
          style: kBodyTextStyleNormal16,
        )),
      ],
    );
  }
}
