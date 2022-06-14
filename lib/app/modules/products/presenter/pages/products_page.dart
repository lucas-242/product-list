import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/models/products_options.dart';
import 'package:product_list/app/modules/products/presenter/pages/product_update_page.dart';
import 'package:product_list/app/modules/products/presenter/widgets/confirmation_dialog.dart';
import 'package:product_list/app/modules/products/presenter/widgets/product_card.dart';
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
    final bloc = context.watch<ProductsBloc>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle(title: 'Products'),
            Expanded(
              child: bloc.state.when(
                onState: (state) => _buildList(context, bloc),
                onError: (state) => _buildError(context, bloc),
                onNoData: () => _buildNoData(context, bloc),
                onLoading: () =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
            BlocListener<ProductsBloc, ProductsState>(
              listenWhen: (previous, current) => current is ListedState,
              listener: (context, state) {
                if (bloc.state.message != null &&
                    bloc.state.message!.isNotEmpty) {
                  _showErrorOnSnackbar(bloc.state.message!);
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, ProductsBloc bloc) {
    return ListView.builder(
      itemCount: bloc.state.products.length,
      itemBuilder: (context, index) {
        var product = bloc.state.products[index];
        return ProductCard(
            product: product,
            onChanged: (option) =>
                _onChangedProductCardOption(option, bloc, product));
      },
    );
  }

  Widget _buildError(BuildContext context, ProductsBloc bloc) {
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

  Widget _buildNoData(BuildContext context, ProductsBloc bloc) {
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

  void _onChangedProductCardOption(
      ProductsOptions? option, ProductsBloc bloc, Product product) {
    if (option != null && option == ProductsOptions.delete) {
      _onDeleteOptionSelected(bloc, product);
    } else if (option != null && option == ProductsOptions.update) {
      _onUpdateOptionSelected(product);
    }
  }

  void _showErrorOnSnackbar(String message) {
    Future.delayed(Duration.zero, () {
      var colors = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: colors.error),
          ),
          backgroundColor: colors.errorContainer,
        ),
      );
    });
  }

  void _onDeleteOptionSelected(Bloc bloc, Product product) {
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

  void _onUpdateOptionSelected(Product product) {
    Navigator.of(context)
        .push(ProductUpdatePage.route(initialProduct: product));
  }
}
