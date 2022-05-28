import 'package:assignment/notification/notification_handler.dart';
import 'package:assignment/repository/products_repository.dart';
import 'package:assignment/ui/product_list/bloc/product_list_bloc.dart';
import 'package:assignment/ui/product_list/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) {
          return ProductListBloc(productRepository: ProductsRepositoryImpl());
        },
        child: const ProductListWidget(),
      ),
    );
  }
}
