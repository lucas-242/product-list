import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class FirebaseProductsDatasource implements ProductsDatasource {
  final String productsTable = 'proucts';
  final FirebaseFirestore _firestore;

  FirebaseProductsDatasource(this._firestore);

  @override
  Stream<List<ProductModel>> getProducts() {
    try {
      Stream<QuerySnapshot> snapshots =
          _firestore.collection(productsTable).snapshots();
      var result = _querySnapshotToProductModel(snapshots);
      return result;
    } catch (e) {
      throw ProductsFailure('Erro to get data from firebase');
    }
  }

  Stream<List<ProductModel>> _querySnapshotToProductModel(
      Stream<QuerySnapshot<Object?>> snapshot) {
    var result = snapshot.map((query) => query.docs
        .map((DocumentSnapshot document) =>
            _documentSnapshotToProductModel(document))
        .toList());
    return result;
  }

  ProductModel _documentSnapshotToProductModel(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var result = ProductModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
