import 'package:emarket/data/network/network_api_services.dart';

class LoginRepository {
  final apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    // why Future<dynamic> ?
    // dynamic response = await apiService.postApi(data, AppUrl.loginUrl);
    // return response;
  }
}
