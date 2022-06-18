import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';
import 'package:product_list/app/modules/products/presenter/models/products_options.dart';
import 'package:product_list/app/modules/products/presenter/pages/products_page.dart';
import 'package:product_list/app/modules/products/presenter/widgets/product_card.dart';
import 'package:product_list/app/shared/extensions/extensions.dart';

import '../../../../firebase_mocks.dart';
import '../../mock_products_test.dart';

void main() {
  late ProductsBloc productsBloc;
  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    productsBloc = MockProductsBloc();
  });

  tearDown(() {
    productsBloc = MockProductsBloc();
  });

  Widget buildSubject() {
    return BlocProvider<ProductsBloc>(
      create: (_) => productsBloc,
      child: const MaterialApp(
        home: ProductsPage(),
      ),
    );
  }

  group('Get', () {
    setUp(() {
      when(() => productsBloc.state)
          .thenReturn((ListedState(products: productList)));
    });

    testWidgets('Should render products list', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();
      expect(find.byType(ProductCard), findsWidgets);
    });
  });

  group('Delete', () {
    const message = 'Test was a success';
    setUp(() {
      when(() => productsBloc.state)
          .thenAnswer((_) => ListedState(products: productList));

      whenListen<ProductsState>(
        productsBloc,
        Stream.fromIterable([
          LoadingState(products: productList),
          ListedState(products: productList, message: message),
        ]),
      );
    });

    Future<void> _getAndTapDeleteOnProduct(WidgetTester tester) async {
      final dropdown = find.descendant(
          of: find.byType(ProductCard).last,
          matching: find.byType(DropdownButton<ProductsOptions>));

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final dropdownItem =
          find.text(ProductsOptions.delete.toShortString().capitalize()).last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();
    }

    testWidgets('Should open delete alert dialog', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await _getAndTapDeleteOnProduct(tester);

      expect(find.byKey(const Key("AlertDialog")), findsOneWidget);
    });

    testWidgets('Should delete product', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await _getAndTapDeleteOnProduct(tester);

      final deleteButton = find.descendant(
          of: find.byType(AlertDialog), matching: find.text('Delete'));

      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("AppSnackbar"), skipOffstage: false),
          findsOneWidget);
      // expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
