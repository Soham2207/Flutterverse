import 'package:flutter/material.dart';
import 'package:flutterverse/item_model.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Item> cart = [];

  void addCounter() {
    _counter++;
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    notifyListeners();
  }

  int getCounter() {
    return counter;
  }

  void addQuantity(String name) {
    final index = cart.indexWhere((element) => element.name == name);
    cart[index].quantity += 1;
    notifyListeners();
  }

  void removeQuantity(String name) {
    final index = cart.indexWhere((element) => element.name == name);
    if (cart[index].quantity == 1) {
      cart[index].quantity = 1;
    } else {
      cart[index].quantity -= 1;
    }
    notifyListeners();
  }

  void removeItem(String name) {
    final index = cart.indexWhere((element) => element.name == name);
    cart.removeAt(index);
    notifyListeners();
  }

  void addTotalPrice(double price) {
    _totalPrice += price;
    notifyListeners();
  }

  void subtractTotalPrice(double price) {
    _totalPrice -= price;
    notifyListeners();
  }

  double getTotalPrice() {
    return totalPrice;
  }

  void addItem(Item item) {
    cart.add(item);
    notifyListeners();
  }
}
