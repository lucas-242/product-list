import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/usecases/update_product.dart';

import '../../mock_products_test.dart';
import '../../mock_products_test.mocks.dart';

void main() {
  final repository = MockProductRepositoryTest();
  final usecase = UpdateProductImpl(repository);

  var invalidProduct = Product(
    id: 'test',
    title: 'test',
    type: 'test',
    filename: 'test.png',
    price: 0,
  );

  test('should update product', () async {
    when(repository.updateProduct(any))
        .thenAnswer((_) async => Future.delayed(const Duration(seconds: 1)));

    expect(usecase.call(product), completes);
  });

  test('should throw InvalidProductException', () async {
    expect(usecase.call(invalidProduct), throwsA(isA<InvalidProductFailure>()));
  });
}
