import 'package:product_list/app/modules/products/infra/models/product_model.dart';

abstract class ProductsDatasource {
  Stream<List<ProductModel>> getProducts();
  Future<void> createProducts(List<ProductModel> products);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(ProductModel product);
}
