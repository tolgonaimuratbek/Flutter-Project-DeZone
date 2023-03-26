import 'package:carousel_slider/carousel_slider.dart';
import 'package:de_zone/common/widgets/circular.dart';
import 'package:de_zone/constants.dart';
import 'package:de_zone/kurse/reusable_course_title.dart';
import 'package:de_zone/kurse/reusable_course_carousel.dart';
import 'package:de_zone/kurse/reusable_hero_category_cards.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:de_zone/screens_login_registration/login_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar_course.dart';
import 'model_product.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> products = [];
  bool areDataLoading = true;
  String? errorInfo;
  @override
  void initState() {
    super.initState();
    final courseAndCategoryProvider =
        Provider.of<CourseAndCategoryProvider>(context, listen: false);
    //Kurs Daten von der Tabelle holen
    courseAndCategoryProvider.fetchCourses().then((res) {
      if (res == null || res != 'done') {
        setState(() {
          errorInfo = 'Fehler aufgetreten. Bitte versuchen Sie später!';
        });
      }
      setState(() {
        areDataLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseAndCategoryProvider =
        Provider.of<CourseAndCategoryProvider>(context);
    return Scaffold(
      appBar: CourseAppBar(),
      body: areDataLoading == true
          ? circular()
          : errorInfo != null && areDataLoading == false
              ? Center(child: Text(errorInfo!))
              : DelayedDisplay(
                  slidingCurve: Curves.easeInCirc,
                  slidingBeginOffset: const Offset(0.35, 0.0),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2.0, //1.5
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: courseAndCategoryProvider.categories
                            .map((category) =>
                                //Die Einzelnen Kurs Kategorien - z.B. A1 Kurse
                                HeroCarouselCard(category: category))
                            .toList(),
                      ),
                      // GRUPPENKURSE
                      const ReusableCourseTitle(title: 'GRUPPENKURSE'),
                      CourseCarousel(
                        //Liste der Gruppenkurse
                        products: courseAndCategoryProvider.courses
                            .where((product) => product.isGeneralCourse!)
                            .toList(),
                      ),
                      // PRÜFUNGSVORBEREITUNGSKURSE
                      const ReusableCourseTitle(
                          title: 'PRÜFUNGSVORBEREITUNGSKURSE'),
                      CourseCarousel(
                        //Liste der Prüfungsvorbereitungskurse
                        products: courseAndCategoryProvider.courses
                            .where((product) => product.isExamPrepCourse!)
                            .toList(),
                      ),
                    ],
                  ),
                ),
    );
  }

/*
  //header widget
  Widget headerWidget() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('images/example_profile_avatar.png'),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            //show user name, email
            Text('name', style: TextStyle(color: kColourBlueMain)),
            SizedBox(height: 10),
            Text('email', style: TextStyle(color: kColourBlueMain)),
          ],
        )
      ],
    );
  }

  //method reusableListTile
  ListTile reusableListTile(IconData icon1, Widget text, Function() onTap) {
    return ListTile(
      textColor: kColourBlueMain,
      title: text,
      leading: Icon(
        icon1,
        color: kColourBlueMain,
      ),
      onTap: onTap,
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
 */
}
