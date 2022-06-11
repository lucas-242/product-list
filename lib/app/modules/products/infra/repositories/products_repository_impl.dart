import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Stream<List<Product>> getProducts() {
    try {
      return datasource.getProducts();
    } catch (e) {
      throw ProductsFailure('Error to get products');
    }
  }

  @override
  Future<void> updateProduct(Product product) {
    try {
      var toUpdate = ProductModel.fromProduct(product);
      return datasource.updateProduct(toUpdate);
    } catch (e) {
      throw ProductsFailure('Error to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) {
    try {
      return datasource.deleteProduct(id);
    } catch (e) {
      throw ProductsFailure('Error to delete product');
    }
  }
}
