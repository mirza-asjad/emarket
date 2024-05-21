// ignore_for_file: avoid_print

import 'package:emarket/db/local_db.dart';
import 'package:get/get.dart';
import 'package:emarket/data/response/status.dart';
import 'package:emarket/model/home_model/product_model.dart';

import 'package:emarket/repository/home_repo.dart';

class HomeViewModel extends GetxController {
  final api = HomeRepository();
  final dbHelper = DatabaseHelper.instance;

  final rxRequestStatus = Status.LOADING.obs;
  final homeList = <ProductModel>[].obs; // Initialize as an empty list
  RxString error = ''.obs;

  void setrxRequestStatus(Status value) {
    rxRequestStatus.value = value;
  }

  void sethomeList(List<ProductModel> value) {
    homeList.assignAll(value); // Assign the new list to the observable list
  }

  void setError(String value) {
    error.value = value;
  }

  void fetchHomeApi() async {
    // Check if the database has data
    final products = await dbHelper.getAllProducts();
    if (products.isNotEmpty) {
      // Database has data, set the homeList and request status
      sethomeList(products);
      setrxRequestStatus(Status.COMPLETED);
      return; // Exit the method, no need to call the API
    }

    // Database is empty, call the API to fetch data
    api.fetchApi().then((value) async {
      setrxRequestStatus(Status.COMPLETED);
      sethomeList(value);

      // Store the fetched products and categories in the local database
      for (ProductModel product in value) {
        await dbHelper.insertProduct(product);
        if (product.category != null) {
          await dbHelper.insertCategory(product.category!);
        }
        print('Inserted product: ${product.title}');
      }
      print('Fetched values inserted into the database');
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error);
      print(stackTrace); // for error background ***important concept
      setrxRequestStatus(Status.ERROR);
    });
  }
}
