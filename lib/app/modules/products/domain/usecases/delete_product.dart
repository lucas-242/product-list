import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';

abstract class DeleteProduct {
  Future<void> call(String id);
}

class DeleteProductImpl implements DeleteProduct {
  final ProductsRepository repository;

  DeleteProductImpl(this.repository);

  @override
  Future<void> call(String id) async {
    await repository.deleteProduct(id);
  }
}
