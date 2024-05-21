import 'package:emarket/db/local_db.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt cartCount = 0.obs;
  RxInt favItemCount = 0.obs;

  Stream<int> get cartCountStream => cartCount.stream;
  Stream<int> get favItemCountStream => favItemCount.stream;

  @override
  void onInit() {
    super.onInit();
    updateCartCount();
    updateFavItemCount();
  }

  void updateCartCount() async {
    int count = await DatabaseHelper.instance.getCartItemCount();
    print('Updating cart count to: $count');
    cartCount.value = count;
  }

  void updateFavItemCount() async {
    int count = await DatabaseHelper.instance.getFavItemCount();
    print('Updating favorite item count to: $count');
    favItemCount.value = count;
  }
}
