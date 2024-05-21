// ignore_for_file: unused_import, use_super_parameters, must_be_immutable

import 'package:emarket/views/emarketUI/details/details_screen.dart';
import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:emarket/views/emarketUI/products/allproducts.dart';
import 'package:flutter/material.dart';
import 'package:emarket/db/local_db.dart';
import 'package:emarket/model/home_model/product_model.dart';
import 'package:get/get.dart';
//import 'package:emarket/widgets/products/product_card.dart'; // Import the ProductCard widget if not already imported
//import 'package:emarket/widgets/details/details_screen.dart'; // Import the DetailsScreen if not already imported

import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: DatabaseHelper.instance.getRandomProducts(10),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(
                  title: "Popular Products",
                  press: () {
                    Get.to(() => AllProductsScreen());
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...snapshot.data!.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductCardforProducts(
                          product: product,
                          // onPress: () => Navigator.pushNamed(
                          //   context,
                          //   DetailsScreen.routeName,
                          //   arguments: ProductDetailsArguments(product: product),
                          // ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class ProductCardforProducts extends StatefulWidget {
  ProductModel product;

  ProductCardforProducts({
    super.key,
    required this.product,
  });

  @override
  State<ProductCardforProducts> createState() => _ProductCardforProductsState();
}

class _ProductCardforProductsState extends State<ProductCardforProducts> {
  CartController cartController = Get.put<CartController>(CartController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => const DetailsScreen(),
          arguments: ProductDetailsArguments(product: widget.product),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                widget.product.images!.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error); // Show an error icon
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.title != null
                    ? _limitTitle(widget.product.title!, 15)
                    : 'No Product',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    getPriceText(widget.product.price!),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // SizedBox(
                //   width: 50,
                // ),
                Row(
                  children: [
                    IconButton(
                      icon: widget.product.isFav
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_outline),
                      onPressed: () async {
                        // Toggle the favorite status of the product
                        final updatedProduct = widget.product
                            .copyWith(isFav: !widget.product.isFav);
                        await DatabaseHelper.instance
                            .updateProduct(updatedProduct);

                        // Update the UI
                        setState(() {
                          widget.product = updatedProduct;
                        });
                      },
                    ),
                    IconButton(
                      icon: widget.product.isCart
                          ? Icon(Icons.shopping_cart)
                          : Icon(Icons.shopping_cart_outlined),
                      onPressed: () async {
                        // Toggle the cart status of the product
                        final updatedProduct = widget.product
                            .copyWith(isCart: !widget.product.isCart);
                        await DatabaseHelper.instance
                            .updateProduct(updatedProduct);
                         cartController.updateCartCount();

                        // Update the UI
                        setState(() {
                          widget.product = updatedProduct;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _limitTitle(String title, int maxCharacters) {
    if (title.length <= maxCharacters) {
      return title;
    } else {
      return title.substring(0, maxCharacters) + '...';
    }
  }

  String getPriceText(int price) {
    if (price >= 1000000000000000000) {
      return '\$${(price / 1000000000000000000).toStringAsFixed(1)}T';
    }
    if (price >= 1000000000000) {
      return '\$${(price / 1000000000000).toStringAsFixed(1)}T';
    } else if (price >= 1000000000) {
      return '\$${(price / 1000000000).toStringAsFixed(1)}B';
    } else if (price >= 1000000) {
      return '\$${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '\$${(price / 1000).toStringAsFixed(1)}K';
    } else {
      return '\$$price';
    }
  }
}
