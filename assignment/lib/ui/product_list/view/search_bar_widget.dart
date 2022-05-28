import 'package:assignment/ui/product_list/bloc/product_list_bloc.dart';
import 'package:assignment/ui/product_list/bloc/product_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _textController = TextEditingController();
  late ProductListBloc productsBloc;

  @override
  void initState() {
    super.initState();
    productsBloc = context.read<ProductListBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        productsBloc.add(ProductSearchTextChanged(text));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: 'Search Products',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    productsBloc.add(ProductsFetchEvent());
  }
}
