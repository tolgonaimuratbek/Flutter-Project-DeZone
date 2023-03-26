import 'package:flutter/material.dart';
import 'constants.dart';

//CustomAppBar um zurück zu navigieren
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: kColourBlueMain,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  //AppBar Höhe
  @override
  Size get preferredSize => Size.fromHeight(30.0);
}

///APPBAR - AppBarArrowBackLeftCenterTitle
class AppBarArrowBackLeftTitleCenter extends StatelessWidget
    with PreferredSizeWidget {
  final String title;

  const AppBarArrowBackLeftTitleCenter({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: kColourBlueMain,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Container(
        //left, top, right, bottom
        padding: EdgeInsets.fromLTRB(70, 15, 0, 0),
        child: Text(
          title,
          style: kTitleTextStyleBoldSize18,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //heighg of AppBar
  @override
  Size get preferredSize => Size.fromHeight(30.0);
}
