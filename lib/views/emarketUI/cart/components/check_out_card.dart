// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emarket/db/local_db.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  Map<String, dynamic>? paymentIntent;
  CartController cartController = Get.put<CartController>(CartController());

  void makePayment(String price) async {
    try {
      print('Price to pay: $price');
      paymentIntent = await createPaymentIntent(price);

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "US", testEnv: true);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Mirza Asjad Basharat',
        googlePay: gpay,
      ));

      showPaymentSheet();
    } catch (e) {}
  }

  void showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Done');
    } catch (e) {
      print('Failed');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String price) async {
    try {
      print('Price to pay: $price');
      String apiKey =
          '';  //add your apiKey
      Map<String, dynamic> body = {
        'amount': price,
        'currency': 'USD',
      };
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        // Payment Intent created successfully
        await DatabaseHelper.instance.removeAllProductsFromCart();
        cartController.updateCartCount();

        return json.decode(response.body);
      } else {
        // Payment Intent creation failed
        print('Failed to create Payment Intent: ${response.statusCode}');
        return Future.error(
            'Failed to create Payment Intent: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during the request
      print('Error creating Payment Intent: $e');
      return Future.error('Error creating Payment Intent: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<int>(
              stream: DatabaseHelper.instance.getTotalCartPriceStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error calculating total price');
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset("assets/icons/receipt.svg"),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: "\$${snapshot.data!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            makePayment(snapshot.data!.toString());
                          },
                          child: const Text("Check Out"),
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
