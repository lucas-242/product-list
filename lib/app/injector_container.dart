import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:product_list/app/modules/products/injector_container.dart'
    as products;

final instance = GetIt.instance;

Future<void> init() async {
  instance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  await products.init();
}
