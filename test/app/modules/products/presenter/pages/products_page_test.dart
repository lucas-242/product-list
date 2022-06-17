import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/pages/products_page.dart';
import 'package:product_list/app/modules/products/presenter/widgets/product_card.dart';

import '../../../../firebase_mocks.dart';
import '../../mock_products_test.dart';
import '../../mock_products_test.mocks.dart';

void main() {
  final productsBloc = MockTestProductsBloc();
  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    when(productsBloc.state)
        .thenAnswer((_) => ListedState(products: productList));
    when(productsBloc.stream).thenAnswer((_) =>
        Stream<ProductsState>.fromIterable(
            [ListedState(products: productList)]));
  });

  Widget buildSubject() {
    return BlocProvider<ProductsBloc>(
      create: (_) => productsBloc,
      child: const MaterialApp(
        home: ProductsPage(),
      ),
    );
  }

  testWidgets('Should render product list', (tester) async {
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();
    expect(find.byType(ProductCard), findsWidgets);
  });
}
