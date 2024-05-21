// ignore_for_file: unnecessary_const

import 'package:emarket/db/local_db.dart';
import 'package:emarket/views/emarketUI/home/components/popular_product.dart';
import 'package:flutter/material.dart';
import 'package:emarket/model/home_model/product_model.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryID;
  const ProductsScreen({super.key, required this.categoryID});

  static String routeName = "/products";

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductsByCategory(widget.categoryID);
  }

  Future<void> fetchProductsByCategory(int id) async {
    final dbHelper = DatabaseHelper.instance;
    final fetchedProducts = await dbHelper.getProductsByCategoryId(id);
    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: const CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        200, // Adjust this based on your image size and desired spacing
                    childAspectRatio:
                        0.6, // Adjust this to fit your images properly
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCardforProducts(
                    product: products[index],
                  ),
                ),
              ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.images!.first,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error); // Show an error icon as a placeholder
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title ?? 'No Product',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('\$${product.price}',
                style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
