import 'package:assignment/model/product.dart';
import 'package:equatable/equatable.dart';

class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductListState {}

class ProductsLoaded extends ProductListState {
  const ProductsLoaded(this.productList);

  final List<Product> productList;

  @override
  List<Object> get props => [productList];
}

class ProductsSearchResult extends ProductListState {
  const ProductsSearchResult(this.productList);

  final List<Product> productList;

  @override
  List<Object> get props => [productList];
}

class ProductsError extends ProductListState {}
