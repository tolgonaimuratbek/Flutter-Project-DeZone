import 'package:de_zone/app_bar.dart';
import 'package:de_zone/constants.dart';
import 'package:de_zone/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../course_screen.dart';
import 'cart_model.dart';
import 'cart_item_card.dart';

//Einkaufskorbseite
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBarArrowBackLeftTitleCenter(title: 'Warenkorb'),
      bottomNavigationBar: cart.items.isEmpty
          ? const SizedBox()
          : BottomAppBar(
              //BottomAppBar
              color: kColourBlueMain,
              child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: kColourPurpleMain),
                      //es passiert noch nichts wenn man auf "Gehe zur Kasse" drückt, wird später eingefügt
                      onPressed: () {},
                      child: Text(
                        'Gehe zur Kasse',
                        style: kTitleTextStyleBoldSize18.copyWith(
                            color: kColourYellowMain),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: cart.items.isEmpty
            ? const Center(
                //wenn Einkaufskorb leer ist, soll entsprechend angezeig werden
                child: Text('Warenkorb leer', style: kTitleTextStyleBoldSize22))
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            //Methode rechnet aus, ob der Nutzer Preisrabatt erhält oder nicht
                            cart.gotSaleFee(cart.subTotal),
                            style: kBodyTextStyleBold14,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CoursesScreen(); //füge noch Kurse ein Schaltfläche ruft die Kursseite auf
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kColourPurpleMain,
                                  foregroundColor: kColourYellowMain,
                                  shape: RoundedRectangleBorder(),
                                  elevation: 0),
                              child: const Text(
                                'Füge noch Kurse ein',
                                style: kBodyTextStyleBold14,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //PRODUCT CARD
                      SizedBox(
                        height: 320,
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) {
                            var item = cart.items[index];
                            //CartItemCard ist im Einkaufskorb mit Bild, Kursname, Kurspreis, Minussymbol verringern, Kursanzahl, PLussymbol erhöhen
                            return CartItemCard(
                              item: item,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  //PREISKALKULATION
                  Column(
                    children: [
                      Column(
                        children: [
                          Divider(thickness: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'PREIS',
                                          style: kTitleTextStyleBoldSize18,
                                        ),
                                        Text(
                                          //toPrice String mit 2 decimal Stellen
                                          '${cart.subTotal.toPrice()}',
                                          style: kBodyTextStyleBold14,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'PREISRABATT',
                                      style: kTitleTextStyleBoldSize18,
                                    ),
                                    Text(
                                      '- ${cart.sale.toPrice()}',
                                      style: kBodyTextStyleBold14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: kColourBlueMain.withAlpha(50),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                margin: EdgeInsets.all(5.0),
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: kColourBlueMain,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'GESAMTPREIS',
                                        style: kTitleTextStyleBoldSize18
                                            .copyWith(color: kColourYellowMain),
                                      ),
                                      Text(
                                        '${cart.total.toPrice()}',
                                        style: kBodyTextStyleBold14.copyWith(
                                            color: kColourYellowMain),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
