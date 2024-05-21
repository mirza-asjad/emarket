import 'package:badges/badges.dart';
import 'package:emarket/views/emarketUI/cart/cart_screen.dart';
import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;

import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  CartController cartController = Get.put<CartController>(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          GetBuilder<CartController>(
            builder: (cartController) => StreamBuilder<int>(
              stream: cartController.cartCountStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return badge.Badge(
                    badgeContent: Text(
                      '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    position: BadgePosition.topEnd(top: -8, end: -8),
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/Cart Icon.svg"),
                      onPressed: () => Get.to(() => const CartScreen()),
                    ),
                  );
                } else {
                  return badge.Badge(
                    badgeContent: Text(
                      snapshot.data!.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    position: BadgePosition.topEnd(top: -8, end: -8),
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/Cart Icon.svg"),
                      onPressed: () => Get.to(() => const CartScreen()),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          GetBuilder<CartController>(
            builder: (cartController) => StreamBuilder<int>(
              stream: cartController.favItemCountStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return badge.Badge(
                    badgeContent: Text(
                      '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    position: BadgePosition.topEnd(top: -8, end: -8),
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/Bell.svg"),
                      onPressed: () {},
                    ),
                  );
                } else {
                  return badge.Badge(
                    badgeContent: Text(
                      snapshot.data!.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    position: BadgePosition.topEnd(top: -8, end: -8),
                    child: IconButton(
                      icon: SvgPicture.asset("assets/icons/Bell.svg"),
                      onPressed: () {},
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
