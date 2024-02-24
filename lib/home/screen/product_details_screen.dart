import 'package:cart_app_norq/cart/controller/products_provider.dart';
import 'package:cart_app_norq/home/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(product.title ?? ''),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(13)),
        child: TextButton(
          onPressed: () => Provider.of<ProductProvider>(context, listen: false)
              .addToCart(product, context),
          child: Text(
            'Add to cart',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(13)),
                  alignment: Alignment.center,
                  height: 220,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(),
                  child: Image.network(
                    product.image!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "₹ ${product.price?.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(height: 15),
                Text(
                  product.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  product.category ?? '',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  product.description ?? '',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
