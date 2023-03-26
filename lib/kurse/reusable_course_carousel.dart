import 'package:de_zone/kurse/reusable_course_card.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:flutter/material.dart';

//CourseCarousel wird in CoursesScreen verwendet um Gruppenkurse & Prüfunfsvorbereitungskurse anzuzeigen
class CourseCarousel extends StatelessWidget {
  final List<Course> products;

  const CourseCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 145,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          scrollDirection: Axis.horizontal, //Richtung
          itemCount: products.length, //Länge
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CourseCard(
                  course: products[index],
                ));
          },
        ),
      ),
    );
  }
}
