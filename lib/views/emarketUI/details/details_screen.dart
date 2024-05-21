import 'dart:math';

import 'package:emarket/db/local_db.dart';
import 'package:emarket/model/home_model/product_model.dart';
import 'package:emarket/views/emarketUI/cart/cart_screen.dart';
import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CartController cartController = Get.put<CartController>(CartController());

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    var product = agrs.product;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${Random().nextInt(11)}.${Random().nextInt(10)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                const TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () async {
                // Check if the product is already in the cart
                bool isProductInCart = await DatabaseHelper.instance
                    .checkIfProductIsInCart(product.id!);

                if (isProductInCart) {
                  // If the product is already in the cart, navigate to CartScreen
                  Get.to(() => const CartScreen());
                } else {
                  // If the product is not in the cart, add it to the cart
                  final updatedProduct = product.copyWith(isCart: true);
                  await DatabaseHelper.instance.updateProduct(updatedProduct);

                  // Update the cart count
                  cartController.updateCartCount();

                  // Update the UI
                  setState(() {
                    product = updatedProduct;
                  });

                  // Navigate to CartScreen
                  Get.to(() => const CartScreen());
                }
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final ProductModel product;

  ProductDetailsArguments({required this.product});
}
