import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/external/firebase/constants/firebase_constants.dart';
import 'package:product_list/app/modules/products/external/firebase/models/product_firebase_model.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class FirebaseProductsDatasource implements ProductsDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseProductsDatasource(this._firestore, this._storage);

  @override
  Stream<List<ProductModel>> getProducts() {
    try {
      Stream<QuerySnapshot> snapshots =
          _firestore.collection(FirebaseConstants.productsTable).snapshots();
      final result = _querySnapshotToProductModel(snapshots);
      return result;
    } catch (e) {
      throw ProductsFailure('Error to get products from firebase');
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
    final data = snapshot.data() as Map<String, dynamic>;
    final result = ProductFirebaseModel.fromMap(data);
    return result.copyWith(id: snapshot.id);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final toUpdate = ProductFirebaseModel.fromProductModel(product);
      await _firestore
          .collection(FirebaseConstants.productsTable)
          .doc(product.id)
          .update(toUpdate.toMap());
    } catch (e) {
      throw ProductsFailure('Error to update product in firebase');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await _firestore
          .collection(FirebaseConstants.productsTable)
          .doc(id)
          .delete();
    } catch (e) {
      throw ProductsFailure('Error to delete product from firebase');
    }
  }

  @override
  Future<void> createProducts(List<ProductModel> products) async {
    try {
      for (var product in products) {
        final toCreate = ProductFirebaseModel.fromProductModel(product);
        await _firestore
            .collection(FirebaseConstants.productsTable)
            .add(toCreate.toMap());
      }
    } catch (e) {
      throw ProductsFailure('Error to add products in firebase');
    }
  }

  @override
  Future<void> uploadProductImage(File image) async {
    try {
      await _storage.ref(FirebaseConstants.productImagesBucket).putFile(image);
    } catch (e) {
      throw ProductsFailure('Error to upload product image in firebase');
    }
  }
}
