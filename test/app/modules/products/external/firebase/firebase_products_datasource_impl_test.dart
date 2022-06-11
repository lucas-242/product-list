import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_list/app/modules/products/external/firebase/firebase_products_datasource_impl.dart';
import 'package:product_list/app/modules/products/external/firebase/models/product_firebase_model.dart';

import '../../mock_products_test.dart';

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseProductsDatasource(database);

  Future<void> _generateProductsMock() async {
    for (var product in productList) {
      await database
          .collection(datasource.productsTable)
          .add(ProductFirebaseModel.fromProductModel(product).toMap());
    }
  }

  setUp(() async {
    await _generateProductsMock();
  });

  test('Should get products', () async {
    var result = datasource.getProducts();
    result.listen((data) {
      expect(data, isNotEmpty);
      expect(data.every((element) => element.id.isNotEmpty), true);
    });
  });

  test('Should delete product', () async {
    var allProducts = await datasource.getProducts().first;
    var productToDelete = allProducts.first;
    await datasource.deleteProduct(productToDelete.id);
    var products = await datasource.getProducts().first;
    expect(products.map((e) => e.id), isNot(contains(productToDelete.id)));
  });

  test('Should update product', () async {
    var allProducts = await datasource.getProducts().first;
    var productToUpdate =
        allProducts.first.copyWith(title: 'new title test', price: 999);

    await datasource.updateProduct(productToUpdate);

    var products = await datasource.getProducts().first;
    var productUpdated =
        products.firstWhere((product) => product.id == productToUpdate.id);
    expect(productUpdated, productToUpdate);
  });
}
