import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () async {
            setState(() {});
          },
          color: Theme.of(context)
              .primaryColor, // Set the color of the refresh indicator
          showChildOpacityTransition:
              false, // Set to false to avoid opacity transition when refreshing
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                HomeHeader(),
                DiscountBannerCarousel(),
                Categories(),
                SpecialOffers(),
                SizedBox(height: 20),
                PopularProducts(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
