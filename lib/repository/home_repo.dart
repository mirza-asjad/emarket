import 'package:emarket/data/network/network_api_services.dart';
import 'package:emarket/model/home_model/product_model.dart';

import 'package:emarket/res/url/app_url.dart';

class HomeRepository {
  final apiService = NetworkApiServices();

  Future<List<ProductModel>> fetchApi() async {
    dynamic response = await apiService.getApi(AppUrl.allproductUrl);
    if (response is List) {
      List<ProductModel> productList = [];
      for (var productData in response) {
        if (productData is Map<String, dynamic>) {
          productList.add(ProductModel.fromJson(productData));
        }
      }
      return productList;
    } else {
      throw Exception('Invalid data format');
    }
  }
}
