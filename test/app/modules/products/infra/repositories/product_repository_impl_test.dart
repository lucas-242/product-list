import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/infra/repositories/product_repository_impl.dart';

import '../../mock_products_test.dart';
import '../../mock_products_test.mocks.dart';

void main() {
  final datasource = MockProductDatasourceTest();
  final repository = ProductRepositoryImpl(datasource);

  test('Should get products', () async {
    var products = productList;
    var mockStream = MockStreamProductsTest();
    when(datasource.getProducts()).thenAnswer((_) => mockStream);
    when(mockStream.first).thenAnswer((_) => Future.value(products));

    var result = repository.getProducts();
    expectLater(await result.first, isNotEmpty);
  });

  test('Should update product', () {
    var toUpdate = product;
    when(datasource.updateProduct(any))
        .thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));
    expect(repository.updateProduct(toUpdate), completes);
  });
  test('Should delete product', () {
    when(datasource.deleteProduct(any))
        .thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));
    expect(repository.deleteProduct('id'), completes);
  });
}
