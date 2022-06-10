import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/repositories/product_repository.dart';
import 'package:product_list/app/modules/products/infra/datasources/product_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Stream<List<Product>> getProducts() {
    try {
      return datasource.getProducts();
    } catch (e) {
      throw ProductFailure('Error to get products');
    }
  }

  @override
  Future<void> updateProduct(Product product) {
    try {
      var toUpdate = ProductModel.fromProduct(product);
      return datasource.updateProduct(toUpdate);
    } catch (e) {
      throw ProductFailure('Error to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) {
    try {
      return datasource.deleteProduct(id);
    } catch (e) {
      throw ProductFailure('Error to delete product');
    }
  }
}
