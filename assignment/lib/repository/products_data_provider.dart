import 'dart:math';

import 'package:assignment/model/product.dart';

class ProductsDataProvider {
  static final ProductsDataProvider _instance =
      ProductsDataProvider._internal();

  factory ProductsDataProvider() {
    return _instance;
  }

  ProductsDataProvider._internal();

  List<Product> productList = [];

  final _random = Random();

  Product reduceQuantity() {
    Product randomProduct =
        productList.elementAt(_random.nextInt(productList.length));
    --randomProduct.quantity;
    return randomProduct;
  }
}
