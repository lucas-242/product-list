import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';

abstract class CreateProducts {
  Future<void> call();
}

class CreateProductsImpl implements CreateProducts {
  final ProductsRepository repository;

  CreateProductsImpl(this.repository);

  @override
  Future<void> call() async {
    await repository.createProducts();
  }
}
