import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/domain/usecases/get_products.dart';

import '../../mock_products_test.dart';
import '../../mock_products_test.mocks.dart';

void main() {
  final repository = MockProductsRepositoryTest();
  final usecase = GetProductsImpl(repository);

  var products = productList;
  var stream = MockStreamProductsTest();

  when(stream.first).thenAnswer((_) => Future.value(products));

  test('should get products', () async {
    when(repository.getProducts()).thenAnswer((_) => stream);

    var result = usecase.call();
    expectLater(await result.first, isNotEmpty);
  });
}
