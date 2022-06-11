import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_list/app/modules/products/external/firebase/firebase_products_datasource_impl.dart';

import '../../mock_products_test.dart';

void main() {
  final database = FakeFirebaseFirestore();
  final datasource = FirebaseProductsDatasource(database);

  Future<void> _generateProductsMock() async {
    for (var product in productList) {
      await database.collection(datasource.productsTable).add(product.toMap());
    }
  }

  setUp(() async {
    await _generateProductsMock();
  });

  test('Should listen all ShoppingLists', () async {
    var result = datasource.getProducts();
    result.listen((data) {
      expect(data, isNotEmpty);
      expect(data.every((element) => element.id.isNotEmpty), true);
    });
  });
}
