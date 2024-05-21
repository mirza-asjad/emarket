import 'package:emarket/views/emarketUI/home/components/popular_product.dart';
import 'package:flutter/material.dart';
import 'package:emarket/db/local_db.dart';
import 'package:emarket/model/home_model/product_model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LiquidPullToRefresh(
        onRefresh: () async {
          setState(() {});
        },
        showChildOpacityTransition:
            false, // Set to false to avoid opacity transition when refreshing
        child: FutureBuilder<List<ProductModel>>(
          future: DatabaseHelper.instance.getFavoriteProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching favorite products'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No favorite products'));
            } else {
              return Column(
                children: [
                  Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) => ProductCardforProducts(
                          product: snapshot.data![index],
                          // onPress: () => Navigator.pushNamed(
                          //   context,
                          //   DetailsScreen.routeName,
                          //   arguments: ProductDetailsArguments(
                          //     product: snapshot.data![index],
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
