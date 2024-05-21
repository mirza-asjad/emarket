// ignore_for_file: unnecessary_const

import 'package:emarket/db/local_db.dart';
import 'package:emarket/views/emarketUI/home/components/popular_product.dart';
import 'package:flutter/material.dart';
import 'package:emarket/model/home_model/product_model.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  static String routeName = "/products";

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    final dbHelper = DatabaseHelper.instance;
    final fetchedProducts = await dbHelper.getAllProducts();
    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
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

// class ProductCard extends StatelessWidget {
//   final ProductModel product;

//   const ProductCard({
//     Key? key,
//     required this.product,
//     // required Future<Object?> Function() onPress,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(
//             product.images!.first,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Center(
//                   child:
//                       Icon(Icons.error)); // Show an error icon as a placeholder
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               product.title != null
//                   ? _limitTitle(product.title!, 15)
//                   : 'No Product',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text('\$${product.price}',
//                 style: const TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }

//   String _limitTitle(String title, int maxCharacters) {
//     if (title.length <= maxCharacters) {
//       return title;
//     } else {
//       return title.substring(0, maxCharacters) + '...';
//     }
//   }
// }
