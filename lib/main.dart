import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:de_zone/providers/message_provider.dart';
import 'package:de_zone/providers/user_provider.dart';
import 'package:de_zone/bottom_navigation_bar.dart';
import 'package:de_zone/screens_welcome/splash_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DoubleExtensions on double {
  //toPrice String mit 2 decimal Stellen
  String toPrice() => '${toStringAsFixed(2).replaceAll('.', ',')} €';
  double roundTo(int digits) => double.parse(toStringAsFixed(digits));
}

var storageRef = FirebaseStorage.instance.ref();
Future<void> main() async {
  timeago.setLocaleMessages('de', timeago.DeMessages());
  //sicherstellen, dass Firebase initialisiert ist bevor Anwendung ausgeführt wird
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp() speichern
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //state management
        //einmal speichern, und öfters verwenden
        providers: [
          //ChangeNotifierProvider stellt eine Instanz bereit
          ChangeNotifierProvider(create: (_) => CourseAndCategoryProvider()),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteCourseProvider()),
          ChangeNotifierProvider(create: (_) => MessageProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor:
                    kColourWhiteNormal, //Hintergrundfarbe Scaffold
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: kColourBlueMain, //e.g. //Hintergrundfarbe AppBar
                ),
                fontFamily: 'Poppins',
                textTheme: const TextTheme(
                    //bodyText
                    bodyMedium:
                        TextStyle(color: kColourBlueMain //Textfarbe Körper
                            )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: kColourBlueMain)),
            //call SplashScreen()
            home: ScreenBottomNavigationBar()));
  }
}

//ScreenBottomNavigationBar
