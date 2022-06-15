import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';

abstract class UpdateProduct {
  Future<void> call(Product product);
}

class UpdateProductImpl implements UpdateProduct {
  final ProductsRepository repository;

  UpdateProductImpl(this.repository);

  @override
  Future<void> call(Product product) async {
    _validateProduct(product);
    //TODO: usecase should validate if the UI is changing the createdAt property
    return await _updateProduct(repository, product);
  }

  void _validateProduct(Product product) {
    if (product.id.isEmpty ||
        !product.isValidTitle ||
        !product.isValidPrice ||
        !product.isValidType) {
      throw InvalidProductFailure();
    }
  }

  Future<void> _updateProduct(
      ProductsRepository repository, Product product) async {
    await repository.updateProduct(product);
  }
}
