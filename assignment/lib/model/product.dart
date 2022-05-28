import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  late String title;
  late String description;
  late int quantity;

  Product.fromJson(Map<String, dynamic> json) {
    title = json["name"];
    description = json["description"];
    quantity = int.parse(json["quantity"]);
  }

  void onChange() {
    notifyListeners();
  }
}
