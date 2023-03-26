import 'package:de_zone/kurse/cart/cart_item.dart';
import 'package:de_zone/kurse/model_product.dart';

//Abkürzungen von Methoden
abstract class CartMethods {
  void getSubTotal(); //
  void updateTotal(); //
  //Artikel hinzufügem zB ZUM EINKAUFSWAGEN EINFÜGEN oder Plus-Symbol
  void addItem(Item item);
  void updateItem(int index);
  void deleteItem(Item item);
  void incrementItem(Item item); //Artikel erhöhen
  void decrementItem(Item item); //Artikel verringern
  void reset();
  void removeItem(Item item);
  void checkIfCourseInCart(Course? currentCourse);
  void sortItemList(List<Item> list);
  void saleFee(double subtotal); //Preisrabatt der vom Kurspreis berechnet wird
}
