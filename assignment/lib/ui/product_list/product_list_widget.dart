import 'dart:async';

import 'package:assignment/model/product.dart';
import 'package:assignment/notification/notification_handler.dart';
import 'package:assignment/repository/products_data_provider.dart';
import 'package:assignment/ui/product_list/bloc/product_list_bloc.dart';
import 'package:assignment/ui/product_list/bloc/product_list_event.dart';
import 'package:assignment/ui/product_list/bloc/product_list_state.dart';
import 'package:assignment/ui/product_list/view/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  late ProductListBloc _bloc;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<ProductListBloc>(context);
    _bloc.add(ProductsFetchEvent());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Products'),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 56, child: SearchBarWidget()),
          BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsLoaded) {
              List<Product> productList = state.productList;
              return Expanded(
                child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) =>
                        _ProductListItemWidget(productList.elementAt(index))),
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }

  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(minutes: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        _notifyUIAndShowNotification();
      },
    );
  }

  void _notifyUIAndShowNotification() {
    Product product = ProductsDataProvider().reduceQuantity();
    product.onChange();
    NotificationService().showNotification(product.quantity, product.title);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class _ProductListItemWidget extends StatefulWidget {
  final Product product;
  const _ProductListItemWidget(this.product, {Key? key}) : super(key: key);

  @override
  State<_ProductListItemWidget> createState() => _ProductListItemWidgetState();
}

class _ProductListItemWidgetState extends State<_ProductListItemWidget> {
  @override
  void initState() {
    super.initState();
    widget.product.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.product.title),
        subtitle: Text(widget.product.description),
        trailing: Text(widget.product.quantity.toString()),
      ),
    );
  }
}
