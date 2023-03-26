import 'package:cached_network_image/cached_network_image.dart';
import 'package:de_zone/kurse/app_router.dart';
import 'package:de_zone/kurse/cart/cart_item.dart';
import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:de_zone/kurse/product_screen.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

//CourseCard - verwendet in CategoryItemsScreen, WishlistScreen
class CourseCard extends StatelessWidget {
  final Course course;
  final double withFactor;
  final double leftPosition;
  final bool isWishlist;

  const CourseCard({
    Key? key,
    required this.course,
    this.withFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlist = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //provider
    final cart = Provider.of<Cart>(context);
    final favoriteCoursePro = Provider.of<FavoriteCourseProvider>(context);

    final double withValue = MediaQuery.of(context).size.width / withFactor;
    return InkWell(
      onTap: () {
        //ruft Kursseite auf
        AppRouter.routeTo(
          context,
          CourseScreen(
            product: course,
          ),
        );
      },
      //Stack für Image, Kursename, Kurspreis & Symbole
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / withFactor,
            height: 150,
            child: CachedNetworkImage(
              imageUrl: course.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 60,
              left: leftPosition,
              child: Container(
                width: withValue - 5 - leftPosition,
                height: 70,
                decoration: BoxDecoration(
                  color: kColourBlueMain.withAlpha(50),
                ),
              )),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: withValue - 15 - leftPosition,
              height: 60,
              decoration: BoxDecoration(color: kColourBlueMain),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(course.name!,
                              //Kursname
                              style: kBodyTextStyleNormal14.copyWith(
                                  color: kColourYellowMain)),
                          Text(
                            //Kurspreis
                            '${course.price} €',
                            style: kBodyTextStyleNormal14.copyWith(
                                color: kColourYellowMain),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(
                          //Plus-Symbol
                          Icons.add_circle,
                          color: kColourYellowMain,
                        ),
                        onPressed: () {
                          //Plus-Symbol auf der ProductCard zum einfügen von Kursen in den Warenkorb
                          cart.addItem(Item(course: course));
                        },
                      ),
                    ),
                    //Entfernen-Symbol wird nur in der Favoritenliste/Wunschliste verwendet
                    isWishlist
                        ? Expanded(
                            child: IconButton(
                              icon: const Icon(
                                //Entfernen-Symbol
                                Icons.delete,
                                color: kColourYellowMain,
                              ),
                              onPressed: () {
                                //Entfernen-Symbol auf der ProductCard zum entfernen von Kursen aus der Favoritenliste
                                favoriteCoursePro.removeCourse(course);
                              },
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
