// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:emarket/db/local_db.dart';
import 'package:emarket/views/emarketUI/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emarket/components/round_button.dart';
import 'package:emarket/data/response/status.dart';
import 'package:emarket/view_model/controller/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = Get.put(HomeViewModel());

  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  bool isloading = false;
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    homeViewModel.fetchHomeApi();
    _showDatabaseContents();
  }

  Future<void> _refreshData() async {
    setState(() {
      isloading = true; // Set loading to true before the API call
    });

    // Make the API call
    homeViewModel.fetchHomeApi();

    setState(() {
      isloading = false; // Set loading to false after the API call completes
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Obx(() {
            switch (homeViewModel.rxRequestStatus.value) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                if (homeViewModel.error.value == 'null') {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Something went wrong',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20),
                        RoundButton(
                          title: 'Retry',
                          loading: isloading,
                          onPressed: _refreshData,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text(homeViewModel.error.toString()));
                }

              //UI part
              case Status.COMPLETED:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.off(() => InitScreen());
                });
                return const SizedBox(); // Return an empty widget
            }
          }),
        ),
      ),
    );
  }

  void _showDatabaseContents() async {
    final products = await dbHelper.getAllProducts();
    final categories = await dbHelper.getAllCategories();

    print('Products:');
    for (var product in products) {
      print('ID: ${product.id}, Title: ${product.title}');
    }

    print('Categories:');
    for (var category in categories) {
      print('ID: ${category.id}, Name: ${category.name}');
    }
  }
}
