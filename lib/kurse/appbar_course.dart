import 'package:de_zone/constants.dart';
import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/kurse/wishlist_screen.dart';
import 'package:de_zone/providers/course_and_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'cart/cart_screen.dart';

//AppBar mit Favoriten-Symbol und Einkaufskorb-Symbol verwendet in CoursesScreen
class CourseAppBar extends StatelessWidget with PreferredSizeWidget {
  const CourseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishlistScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.favorite_outline,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: kColourBlueMain,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: badges.Badge(
                  badgeContent: Text(
                    //Anzahl der eingefügten Kurse im Warenkorb werden angezeigt rot mit weisser Textfarbe
                    cart.totalQty.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                  )))
        ]);
  }

  //AppBar Größe
  @override
  Size get preferredSize => Size.fromHeight(30.0);
}
