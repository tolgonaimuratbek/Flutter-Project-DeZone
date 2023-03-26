import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:de_zone/constants.dart';
import 'package:de_zone/kurse/cart/cart_item.dart';
import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/kurse/reusable_hero_category_cards.dart';
import 'package:de_zone/providers/favorite_course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_bar.dart';
import 'model_product.dart';

//Kursbeschreibungsseite mit Bild, Kursnamen, Kurspries, Kursinformation, Zahlungsinformation...
//..Favoritenschaltfläche, Schaltfläche um den jeweiligen Kurs in den Warenkorb einzufügen
class CourseScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Course product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CourseScreen(product: product),
    );
  }

  final Course product;

  const CourseScreen({required this.product});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favoriteCoursePro = Provider.of<FavoriteCourseProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomAppBar(
        color: kColourBlueMain,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                //hier beim Teilen-Symbol passiert noch nichts
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  color: kColourYellowMain,
                ),
              ),
              IconButton(
                onPressed: () {
                  //beim drücken auf Favoriten-Symbol Kurs auf Favoriten/Wunschliste einfügen
                  favoriteCoursePro.addCourse(product);
                },
                icon: const Icon(
                  Icons.favorite_outline,
                  color: kColourYellowMain,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kColourPurpleMain),
                onPressed: () {
                  //beim drücken auf Schaltfläche Kurs in den Warenkorb einfügen
                  cart.addItem(Item(course: product));
                },
                child: Text(
                  'ZUM EINKAUFSWAGEN EINFÜGEN',
                  style:
                      kBodyTextStyleBold14.copyWith(color: kColourYellowMain),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0, //1.5
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              HeroCarouselCard(product: product),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: kColourBlueMain.withAlpha(50),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  color: kColourBlueMain,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name!,
                          style: kTitleTextStyleNormalSize18.copyWith(
                              color: kColourYellowMain),
                        ),
                        Text(
                          '${product.price} €',
                          style: kTitleTextStyleNormalSize18.copyWith(
                              color: kColourYellowMain),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Kursinformation',
                style: kTitleTextStyleNormalSize22.copyWith(
                    color: kColourBlueMain),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et '
                    'dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. '
                    'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ',
                    style:
                        kBodyTextStyleNormal14.copyWith(color: kColourBlueMain),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              title: Text(
                'Zahlungsinfromation',
                style: kTitleTextStyleNormalSize22.copyWith(
                    color: kColourBlueMain),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et '
                    'dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. '
                    'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ',
                    style:
                        kBodyTextStyleNormal14.copyWith(color: kColourBlueMain),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
