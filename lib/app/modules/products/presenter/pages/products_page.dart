import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/app/modules/products/presenter/bloc/bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProductsBloc>();
    bloc.add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProductsBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Products'),
          SizedBox(
            height: 500,
            child: bloc.state.when(
              onState: _buildList,
              onLoading: () => const Center(child: CircularProgressIndicator()),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildList(ProductsState state) {
  return ListView.builder(
    itemCount: state.products.length,
    itemBuilder: (context, index) => Text(state.products[index].title),
  );
}
