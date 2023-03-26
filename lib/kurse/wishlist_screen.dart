import 'package:de_zone/app_bar.dart';
import 'package:de_zone/kurse/reusable_course_card.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model_product.dart';
//Favoritenseite für Kurse

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(),
      builder: (context) => WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseAndCategoryProvider =
        Provider.of<CourseAndCategoryProvider>(context);
    final favProvider = Provider.of<FavoriteCourseProvider>(context);

    return Scaffold(
      appBar: AppBarArrowBackLeftTitleCenter(title: 'Wunschliste'),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        //crossAxisCount - ein Kurs pro Reihe
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 2.2),
        itemCount: favProvider.courses.length,
        itemBuilder: (BuildContext context, int index) {
          var course = favProvider.courses[index];
          return Center(
            child: CourseCard(
              course: course,
              withFactor: 1.1,
              leftPosition: 100,
              isWishlist: true,
            ),
          );
        },
      ),
    );
  }
}
