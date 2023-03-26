import 'package:cached_network_image/cached_network_image.dart';
import 'package:de_zone/kurse/app_router.dart';
import 'package:de_zone/kurse/category_items_screen.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'model_category.dart';
import 'model_product.dart';

//Die Einzelnen Kurs Kategorien - z.B. A1 Kurse

class HeroCarouselCard extends StatelessWidget {
  final Category? category;
  final Course? product;
  const HeroCarouselCard({this.category, this.product});

  @override
  Widget build(BuildContext context) {
    final courseAndCategoryProvider =
        Provider.of<CourseAndCategoryProvider>(context);

    return InkWell(
      onTap: () {
        if (category != null) {
          AppRouter.routeTo(
            context,
            CategoryItemsScreen(
              category: category!,
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: product == null
                      ? category!.imageUrl!
                      : product!.imageUrl!,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      //Kategoriename e.g. A2 Kurse
                      product == null ? category!.name! : '',
                      style: kTitleTextStyleNormalSize22.copyWith(
                          color: kColourWhiteNormal),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
