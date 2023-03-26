import 'package:de_zone/app_bar.dart';
import 'package:de_zone/kurse/reusable_course_card.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model_category.dart';
import 'model_product.dart';

//Die Seite der Kurskategorie - e.g. in Kurskategorie A2 sind A1 Gruppe & A1 Prüfung zu finden
class CategoryItemsScreen extends StatelessWidget {
  static const String routeName = '/category';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => CategoryItemsScreen(category: category));
  }

  final Category category;
  const CategoryItemsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final courseAndCategoryProvider =
        Provider.of<CourseAndCategoryProvider>(context);

    category;
    final List<Course> categoryProducts = courseAndCategoryProvider.courses
        .where((product) => product.categoryId == category.id)
        .toList();
    return Scaffold(
        appBar: const CustomAppBar(),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.15),
            itemCount: categoryProducts.length,
            itemBuilder: (BuildContext context, int index) {
              var course = categoryProducts[index];
              return Center(
                  child: CourseCard(
                course: course,
                withFactor: 2.2,
              ));
            }));
  }
}
