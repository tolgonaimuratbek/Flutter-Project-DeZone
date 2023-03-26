import 'package:de_zone/kurse/cart/cart_item.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'cart_methods.dart';

//TODO
class Cart extends ChangeNotifier implements CartMethods {
  List<Item> items = [];
  int totalQty = 0; //Gesamtanzahl verwendet in AppBar Course,
  double subTotal = 0; //Gesamtpreis bevor Rabatt subtrahiert wird
  double total = 0; //Gesamtpreis nachdem Rabatt subtrahiert wird
  //double deliveryCost = 0;
  double sale = 0; //Rabattpreis

  setSaleValue(double val) {
    sale = val;
    notifyListeners();
  }

  //Preisrabatt vom Kurspreis berechnen
  @override
  double saleFee(subtotal) {
    if (subtotal > 350) {
      return 65.0;
    }
    //> 200 Rabatt 45€
    else if (subtotal > 200.0) {
      return 45.0;
      //100-200 Rabatt €25
    } else if (subtotal > 100.0) {
      return 25.0;
      //30-100 Rabatt €15
    } else if (subtotal > 30.0) {
      return 15.0;
      //unter 30 kein Rabatt
    } else {
      return 0.0;
    }
  }

  //Methode rechnet anhand Kurspreis aus, ob der Nutzer Preisrabatt erhhält oder nicht
  //verwendet in CartScreen
  String gotSaleFee(subtotal) {
    if (subtotal > 30) {
      return 'Sie erhalten einen Preisrabatt';
    } else {
      return 'Ab 30€, 100€, 200€ oder 350€ erhalten Sie Preisrabatt';
    }
  }

  //getSubTotal verwendet unten in updateTotal
  @override
  double getSubTotal() {
    double res = 0;
    int ttQty = 0;
    for (var item in items) {
      res += item.totalPrice; //KursPreis ohne Abzug von Preisrabatt berechnen
      ttQty += item.qty; //Artikel
    }
    totalQty = ttQty;
    return res;
  }

  //verwendet in Item (cart_item)
  //Berechnung des Gesamtpreises
  @override
  void updateTotal() {
    subTotal = getSubTotal();
    total = subTotal;
    sale = saleFee(subTotal); //Rabatt vom Kurspreis
    double tempTotal = subTotal - sale; //+
    total = tempTotal < 0 ? 0 : tempTotal;
    notifyListeners();
  }

  //Plus-Symbol auf der CourseCard zum einfügen von Kursen in den Warenkorb
  // @override
  void addItem(Item item) {
    var index =
        items.indexWhere((element) => element.course!.id! == item.course!.id);
    if (index == -1) {
      items.add(item);
    } else {
      updateItem(index);
    }
    updateTotal();
  }

  //Artikel aktualisieren
  @override
  void updateItem(int index) {
    items[index].qty++;
    notifyListeners();
  }

  //Artikel entfernen
  @override
  void deleteItem(Item item) {
    items.remove(item);
    updateTotal();
  }

  //Artikel im Einkaufskorb erhöhen
  @override
  void incrementItem(Item item) {
    var index = items.indexWhere((element) => element.course == item.course!);
    if (index >= 0) {
      items[index].qty += 1;
    }
    updateTotal();
  }

  //Artikel im Einkaufskorb verringern
  @override
  void decrementItem(Item item) {
    var index = items.indexWhere((element) => element.course == item.course);
    if (index >= 0) {
      items[index].qty -= 1;
    }
    updateTotal();
    if (item.qty == 0) {
      items.remove(item);
      return;
    }
  }

  //overrides von Cart
  @override
  void reset() {
    items.clear();
    subTotal = 0;
    total = 0;
    //deliveryCost = 0;
  }

  @override
  Item? checkIfCourseInCart(Course? currentCourse) {
    for (var item in items) {
      if (item.course!.id == currentCourse!.id) {
        return item;
      }
    }
    return null;
  }

  @override
  List<Item> sortItemList(List<Item> list) {
    List<Item> myList = list;
    Comparator<Item> priceComparator = (a, b) {
      return a.totalPrice.compareTo(b.totalPrice);
    };
    myList.sort(priceComparator);
    return myList;
  }

  @override
  void removeItem(Item item) {
    items.remove(item);
    notifyListeners();
  }
}
