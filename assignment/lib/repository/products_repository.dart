import 'dart:convert';

import 'package:assignment/model/product.dart';
import 'package:assignment/repository/products_data_provider.dart';
import 'package:flutter/services.dart';

abstract class ProductsRepository {
  Future<List<Product>> loadProducts();

  Future<List<Product>> searchProducts(String searchText);
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataProvider dataProvider = ProductsDataProvider();

  @override
  Future<List<Product>> loadProducts() async {
    List<Product> productList = dataProvider.productList;
    if (productList.isNotEmpty) return productList;
    String data = await rootBundle.loadString("assets/assignment.json");
    final Map<String, dynamic> jsonResult = json.decode(data);
    final productsJson = jsonResult["products"];
    for (var json in productsJson) {
      productList.add(Product.fromJson(json));
    }
    return productList;
  }

  @override
  Future<List<Product>> searchProducts(String searchText) async {
    Iterable<Product> productIterable = dataProvider.productList.where(
        (element) =>
            element.title.contains(searchText) ||
            element.description.contains(searchText));
    return productIterable.toList();
  }
}
