import 'package:cached_network_image/cached_network_image.dart';
import 'package:de_zone/kurse/cart/cart_item.dart';
import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

//CartItemCard ist im Einkaufskorb mit Bild, Kursname, Kurspreis, Minussymbol verringern, Kursanzahl, PLussymbol erhöhen
class CartItemCard extends StatelessWidget {
  final Item item;

  const CartItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          //Kursbild
          CachedNetworkImage(
            imageUrl: item.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          //Kursname, Kurspreis
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.course!.name!),
                Text(
                  item.course!.price!.toPrice(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              //Minus-Symbol
              IconButton(
                  onPressed: () {
                    //Artikel im Einkaufskorb verringern
                    cart.decrementItem(item);
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: kColourBlueMain,
                  )),
              //Anzahl der Kurse e.g. 2x A2-Prüfung
              Text(item.qty.toString()),
              //Plus-Symbol
              IconButton(
                onPressed: () {
                  //Artikel im Einkaufskorb erhöhen
                  cart.incrementItem(item);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: kColourBlueMain,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
