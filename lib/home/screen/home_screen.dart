import 'package:cart_app_norq/cart/screen/cart_screen.dart';
import 'package:cart_app_norq/home/controller/home_provider.dart';
import 'package:cart_app_norq/cart/controller/products_provider.dart';
import 'package:cart_app_norq/home/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Provider.of<ProductProvider>(context, listen: false)
                    .initiateProductCartList()
                    .whenComplete(() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        )));
              },
              icon: Icon(Icons.shopping_bag),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: value.fetchList(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.data != null) {
                var list = snapshot.data;
                if (list?.isEmpty ?? true) {
                  return Text('No data, Check connection!');
                }
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  children: [
                    ...list!.map(
                      (product) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product),
                              )),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      alignment: Alignment.center,
                                      height: 120,
                                      width: 160,
                                      padding: EdgeInsets.symmetric(),
                                      child: Image.network(
                                        product.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, top: 12),
                                      child: Text(
                                        "₹ ${product.price?.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  product.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  product.category ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(13)),
                                  child: TextButton(
                                    onPressed: () =>
                                        Provider.of<ProductProvider>(context, listen: false).addToCart(product, context),
                                    child: Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
