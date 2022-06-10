import 'package:product_list/app/modules/products/domain/repositories/product_repository.dart';

abstract class DeleteProduct {
  void call(String id);
}

class DeleteProductImpl implements DeleteProduct {
  final ProductRepository repository;

  DeleteProductImpl(this.repository);

  @override
  Future<void> call(String id) async {
    await repository.deleteProduct(id);
  }
}
