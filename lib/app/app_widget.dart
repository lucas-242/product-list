import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/app/modules/products/presenter/bloc/bloc/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/pages/products_page.dart';
import 'package:product_list/app/injector_container.dart' as di;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.instance<ProductsBloc>(),
      child: MaterialApp(
        title: 'Product List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xf000A31F),
          ),
          useMaterial3: true,
        ),
        home: const ProductsPage(),
      ),
    );
  }
}
