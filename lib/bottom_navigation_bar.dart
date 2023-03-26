import 'package:de_zone/chat/contact_list.dart';
import 'package:de_zone/common/widgets/circular.dart';
import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/kurse/app_router.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:de_zone/screens_login_registration/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'kurse/course_screen.dart';
import 'side_bar/sideBar.dart';
import 'lerninhalt/lerninhalt.dart';

class ScreenBottomNavigationBar extends StatefulWidget {
  State<ScreenBottomNavigationBar> createState() => _PageBottomNavigationBar();
}

class _PageBottomNavigationBar extends State<ScreenBottomNavigationBar> {
  int _selectedPageIndex = 0;
  bool isLoading = true;

  //vier Seiten die in der NavigationsBar sind
  final List<Widget> _pages = [
    LerninhaltScreen(),
    ContactList(),
    CoursesScreen(),
    SideBar(),
  ];
  //index
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

//TODO
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final favoriteCoursePro =
        Provider.of<FavoriteCourseProvider>(context, listen: false);

    SettingsCache.instance.getString('userId').then((value) async {
      if (value != null) {
        userProvider.getUserById(value);
        favoriteCoursePro.retrieveCourses();

        setState(() {
          isLoading = false;
        });
      } else {
        AppRouter.routeTo(context, LoginScreen());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(body: circular())
        : Scaffold(
            body: _pages[_selectedPageIndex],
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: kColourYellowMain,
              selectedItemColor: kColourGreyMain,
              currentIndex:
                  _selectedPageIndex, //dem ButtonNavigation mitteilen, welche Seite tatsächlich ausgewählt ist
              type: BottomNavigationBarType
                  .fixed, //Ändern des Stils der Navigationsleiste - Typ verwenden
              onTap: _selectedPage,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Lerneinheit',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  label: 'Kurse',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_outlined),
                  label: 'Menu',
                ),
              ],
            ),
          );
  }
}
