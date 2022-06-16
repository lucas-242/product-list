import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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
  Future<void> updateProduct(Product product) async {
    try {
      var toUpdate = ProductModel.fromProduct(product);
      return await datasource.updateProduct(toUpdate);
    } catch (e) {
      throw ProductsFailure('Error to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      return await datasource.deleteProduct(id);
    } catch (e) {
      throw ProductsFailure('Error to delete product');
    }
  }

  @override
  Future<void> createProducts() async {
    try {
      final data = await _getProducts();
      return await datasource.createProducts(data);
    } catch (e) {
      throw ProductsFailure('Error to delete product');
    }
  }

  Future<List<ProductModel>> _getProducts() async {
    final String response =
        await rootBundle.loadString('assets/data/data.json');
    final data = await json.decode(response) as List;
    final result = data.map((e) => ProductModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<void> uploadProductImage(File image) async {
    try {
      return await datasource.uploadProductImage(image);
    } catch (error) {
      throw ProductsFailure('Error to upload product image');
    }
  }
}
