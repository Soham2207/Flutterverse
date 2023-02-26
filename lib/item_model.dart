import 'package:flutter/cupertino.dart';

class Item {
  final String name;
  final String unit;
  final String price;
  final String image;
  ValueNotifier<int>? quantity;
  Item(
      {required this.name,
      required this.unit,
      required this.price,
      required this.image,
      this.quantity}) {
    quantity = ValueNotifier<int>(1);
  }

  Map toJson() {
    return {
      'name': name,
      'unit': unit,
      'price': price,
      'image': image,
    };
  }
}
