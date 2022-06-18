import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/models/products_options.dart';
import 'package:product_list/app/modules/products/presenter/pages/product_update_page.dart';
import 'package:product_list/app/modules/products/presenter/widgets/confirmation_dialog.dart';
import 'package:product_list/app/modules/products/presenter/widgets/product_card.dart';
import 'package:product_list/app/shared/themes/app_snackbar.dart';
import 'package:product_list/app/shared/themes/typography_utils.dart';
import 'package:product_list/app/shared/widgets/title/app_title.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppTitle(title: 'Products'),
            Expanded(
              child: BlocListener<ProductsBloc, ProductsState>(
                listener: (context, state) {
                  if (state.message != null && state.message!.isNotEmpty) {
                    getAppSnackBar(
                      context: context,
                      message: state.message!,
                      type: state is ErrorState
                          ? SnackBarType.error
                          : SnackBarType.success,
                    );
                  }
                },
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return state.when(
                      onState: (state) => _BuildList(),
                      onError: (state) => _BuildError(),
                      onNoData: () => _BuildNoData(),
                      onLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProductsBloc>();

    return ListView.builder(
      itemCount: bloc.state.products.length,
      itemBuilder: (context, index) {
        var product = bloc.state.products[index];
        return ProductCard(
            key: Key(product.id),
            product: product,
            onChanged: (option) => _onChangedProductCardOption(
                  context: context,
                  option: option,
                  bloc: bloc,
                  product: product,
                ));
      },
    );
  }

  void _onChangedProductCardOption(
      {required BuildContext context,
      ProductsOptions? option,
      required ProductsBloc bloc,
      required Product product}) {
    if (option != null && option == ProductsOptions.delete) {
      _onDeleteOptionSelected(context: context, bloc: bloc, product: product);
    } else if (option != null && option == ProductsOptions.update) {
      _onUpdateOptionSelected(context: context, product: product);
    }
  }

  void _onDeleteOptionSelected(
      {required BuildContext context,
      required Bloc bloc,
      required Product product}) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          product: product,
          onConfirm: () {
            Navigator.of(context).pop();
            bloc.add(DeleteProductEvent(product.id));
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void _onUpdateOptionSelected(
      {required BuildContext context, required Product product}) {
    Navigator.of(context)
        .push(ProductUpdatePage.route(initialProduct: product));
  }
}

class _BuildError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProductsBloc>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bloc.state.message ?? 'There was an error',
            style: context.titleLarge,
          ),
          ElevatedButton(
            onPressed: () => bloc.add(GetProductsEvent()),
            child: const Text('Update page'),
          ),
        ],
      ),
    );
  }
}

class _BuildNoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductsBloc>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There is no data',
            style: context.titleLarge,
          ),
          ElevatedButton(
            onPressed: () => bloc.add(CreateProductsEvent()),
            child: const Text('Generate data'),
          ),
        ],
      ),
    );
  }
}
