import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/domain/usecases/delete_product.dart';

import '../../mock_products_test.mocks.dart';

void main() {
  final repository = MockProductRepositoryTest();
  final usecase = DeleteProductImpl(repository);

  test('should delete product', () async {
    when(repository.deleteProduct(any))
        .thenAnswer((_) async => Future.delayed(const Duration(seconds: 1)));

    expect(usecase.call('id'), completes);
  });
}
