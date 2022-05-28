import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
}

class ProductsFetchEvent extends ProductListEvent {
  @override
  List<Object> get props => [];
}

class ProductSearchTextChanged extends ProductListEvent {
  final String searchText;
  const ProductSearchTextChanged(this.searchText);
  @override
  List<Object> get props => [];
}

class ProductSearchTextCleared extends ProductListEvent {
  @override
  List<Object> get props => [];
}
