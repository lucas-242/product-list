import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/app/modules/products/presenter/bloc/bloc/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/widgets/product_card.dart';
import 'package:product_list/app/shared/themes/typography_utils.dart';

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Text(
                'Products',
                style: context.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 500,
              child: bloc.state.when(
                onState: _buildList,
                onError: (state) => _buildError(context, bloc),
                onLoading: () =>
                    const Center(child: CircularProgressIndicator()),
                // onError: _buildError(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildList(ProductsState state) {
  return ListView.builder(
    itemCount: state.products.length,
    itemBuilder: (context, index) =>
        ProductCard(product: state.products[index]),
  );
}

Widget _buildError(BuildContext context, ProductsBloc bloc) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          bloc.state.errorMessage ?? 'There was an error',
          style: context.titleLarge,
        ),
        ElevatedButton(
          onPressed: () => bloc.add(GetProductsEvent()),
          child: const Text('Update page'),
        )
      ],
    ),
  );
}
