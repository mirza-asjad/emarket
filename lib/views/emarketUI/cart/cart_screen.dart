import 'package:emarket/model/home_model/product_model.dart';
import 'package:emarket/views/emarketUI/cart/components/check_out_card.dart';
import 'package:emarket/views/emarketUI/components/cart_card.dart';
import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:flutter/material.dart';
import 'package:emarket/db/local_db.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<ProductModel>> _fetchCartProducts() async {
    return await DatabaseHelper.instance.getAllCartProducts();
  }

  CartController cartController = Get.put<CartController>(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () async {
          setState(() {});
        },
        showChildOpacityTransition: false,
        child: FutureBuilder<List<ProductModel>>(
          future: _fetchCartProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching cart products'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                  body: const Center(child: Text('No products in the cart')));
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Column(
                    children: [
                      const Text(
                        "Your Cart",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "${snapshot.data!.length} items",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(snapshot.data![index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          setState(() {
                            DatabaseHelper.instance.removeProductFromCart(
                                snapshot.data![index].id!);
                          });
                          cartController.updateCartCount();
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.delete, color: Colors.red),
                            ],
                          ),
                        ),
                        child: CartCard(product: snapshot.data![index]),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: const CheckoutCard(),
              );
            }
          },
        ),
      ),
    );
  }
}
