// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:emarket/db/local_db.dart';
import 'package:emarket/model/home_model/product_model.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  ProductModel product;

  CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _quantity = 1; // Use a local variable to track the quantity

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your existing code...

          Image.network(
            widget.product.images!.first,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                  child:
                      Icon(Icons.error)); // Show an error icon as a placeholder
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.title != null
                  ? _limitTitle(widget.product.title!, 15)
                  : 'No Product',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('\$${widget.product.price}',
                style: const TextStyle(fontSize: 16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  setState(() {
                    if (_quantity > 1) {
                      _quantity--;
                      print('Updated quantity: $_quantity');
                      _updateTotalPrice();
                    }
                  });
                },
              ),
              Text('$_quantity'), // Use the local quantity here
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  setState(() {
                    _quantity++;
                    _updateTotalPrice();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateTotalPrice() async {
    // Calculate the total price based on the initial price and the current quantity
    int totalPrice = widget.product.price! * _quantity;

    // Update the product price in the database
    final updatedProduct = widget.product.copyWith(price: totalPrice);
    await DatabaseHelper.instance.updateProduct(updatedProduct);

    // Update the UI
    setState(() {
      widget.product = updatedProduct;
    });
  }

  String _limitTitle(String title, int maxCharacters) {
    if (title.length <= maxCharacters) {
      return title;
    } else {
      return title.substring(0, maxCharacters) + '...';
    }
  }
}
