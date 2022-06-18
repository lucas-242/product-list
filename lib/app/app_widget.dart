import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';
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
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xf000a420),
          ),
          useMaterial3: true,
        ),
        home: const ProductsPage(),
      ),
    );
  }
}
