import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/repositories/product_repository.dart';

abstract class GetProducts {
  Stream<List<Product>> call();
}

class GetProductsImpl implements GetProducts {
  final ProductRepository repository;

  GetProductsImpl(this.repository);

  @override
  Stream<List<Product>> call() {
    return repository.getProducts();
  }
}
