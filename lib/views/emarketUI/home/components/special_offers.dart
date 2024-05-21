import 'package:emarket/views/emarketUI/products/allproducts.dart';
import 'package:emarket/views/emarketUI/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Special for you",
            press: () {
              Get.to(() => const AllProductsScreen());
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/clothes.jpg",
                category: "Clothes",
                numOfBrands: 32,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  Get.to(() => const ProductsScreen(
                        categoryID: 1,
                      ));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/elect.jpg",
                category: "Electronics",
                numOfBrands: 18,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  Get.to(() => const ProductsScreen(
                        categoryID: 2,
                      ));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/fun.jpg",
                category: "Furniture",
                numOfBrands: 24,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  Get.to(() => const ProductsScreen(categoryID: 3));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/shoes.jpg",
                category: "Shoes",
                numOfBrands: 24,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  Get.to(() => const ProductsScreen(categoryID: 4));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/miscell.jpg",
                category: "Miscellaneous",
                numOfBrands: 24,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  Get.to(() => const ProductsScreen(categoryID: 5));
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
