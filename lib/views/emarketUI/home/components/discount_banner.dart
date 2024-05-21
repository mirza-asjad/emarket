import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DiscountBannerCarousel extends StatelessWidget {
  const DiscountBannerCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> banners = [
      DiscountBanner(
        title: "A Summer Surprise",
        subtitle: "Cashback 20%",
        backgroundColor: const Color(0xFF4A3298),
      ),
      DiscountBanner(
        title: "Winter Sale",
        subtitle: "Up to 50% Off",
        backgroundColor: const Color(0xFF3A4EB8),
      ),
      DiscountBanner(
        title: "Spring Deals",
        subtitle: "Save More Upto 40%",
        backgroundColor: const Color(0xFF3AB8A7),
      ),
      DiscountBanner(
        title: "Autumn Specials",
        subtitle: "Discounts Up to 30%",
        backgroundColor: const Color(0xFFB84E3A),
      ),
      DiscountBanner(
        title: "Holiday Offers",
        subtitle: "Special Prices 25%",
        backgroundColor: const Color(0xFF4EB83A),
      ),
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
        viewportFraction: 1.0,
      ),
      items: banners,
    );
  }
}

class DiscountBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const DiscountBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "$title\n"),
            TextSpan(
              text: subtitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
