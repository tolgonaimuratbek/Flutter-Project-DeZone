import 'package:de_zone/kurse/cart/cart_model.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:uuid/uuid.dart';

//TODO
class Item {
  String id = Uuid().v4();
  int _qty = 0; //Anzahl
  double totalPrice = 0; //KursPreis ohne Abzug von Preisrabatt berechnen
  Course? course;
  Cart? cartModel; //CartModel
  String? _hashKey;
  String? _imageUrl; //String für Bild url

  Item({this.course}) {
    qty = 1;
    hashKey = "";
  }
  //setter für Bild
  set imageUrl(String img) {
    _imageUrl = img;
  }

  //getter für Bild
  String get imageUrl => _imageUrl ?? course!.imageUrl!;

  set hashKey(String hash) {
    _hashKey = hash;
  }

  String get hashKey => _hashKey!;

  //setter für Anzahl
  set qty(int newqty) {
    _qty = newqty;
    updateTotalPrice();
  }

  //getter für Anzahl
  int get qty => _qty;

  //Aktualisierung des Gesamtpreises
  void updateTotalPrice() {
    var oldTotalPrice = totalPrice;
    //Anzahl mit Kurspreis multiplizieren & und in totalPrice speichern
    totalPrice = _qty * course!.price!.toDouble();
    //
    if (oldTotalPrice != totalPrice) cartModel?.updateTotal();
  }
}
