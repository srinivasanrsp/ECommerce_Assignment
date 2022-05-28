import 'package:assignment/repository/products_repository.dart';
import 'package:assignment/ui/product_list/bloc/product_list_event.dart';
import 'package:assignment/ui/product_list/bloc/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductsRepository productRepository;

  ProductListBloc({required this.productRepository})
      : super(ProductsLoading()) {
    on<ProductsFetchEvent>(_onStarted);
    on<ProductSearchTextChanged>(_onProductSearch);
  }

  void _onStarted(
      ProductsFetchEvent event, Emitter<ProductListState> emit) async {
    emit(ProductsLoading());
    try {
      final productList = await productRepository.loadProducts();
      emit(ProductsLoaded(productList));
    } catch (_) {
      emit(ProductsError());
    }
  }

  void _onProductSearch(
      ProductSearchTextChanged event, Emitter<ProductListState> emit) async {
    emit(ProductsLoading());
    try {
      final productList =
          await productRepository.searchProducts(event.searchText);
      emit(ProductsLoaded(productList));
    } catch (_) {
      emit(ProductsError());
    }
  }
}
