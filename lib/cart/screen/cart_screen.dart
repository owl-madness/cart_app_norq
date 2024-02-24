import 'package:cart_app_norq/cart/controller/products_provider.dart';
import 'package:cart_app_norq/home/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) => value.poductCartlist.isEmpty
            ? Center(
                child: Text('No items in cart!'),
              )
            : value.isLoading ? CircularProgressIndicator() : ListView.builder(
                itemCount: value.poductCartlist.length,
                itemBuilder: (context, index) {
                  var product = value.poductCartlist[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(13)),
                                alignment: Alignment.center,
                                height: 120,
                                width: 160,
                                padding: EdgeInsets.symmetric(),
                                child: Image.network(
                                  product.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 12),
                                    child: Text(
                                      "₹ ${(product.price! * product.quantity).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              value.updateRowQuantity(product,
                                                  UpdateQuantityCase.decrement),
                                          icon: Icon(
                                              Icons.remove_circle_outline)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        product.quantity.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () =>
                                              value.updateRowQuantity(product,
                                                  UpdateQuantityCase.increment),
                                          icon: Icon(Icons.add_circle_outline)),
                                    ],
                                  )
                                ],
                              )
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
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            product.category ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            product.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 50,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(13)),
                            child: TextButton(
                              onPressed: () => Provider.of<ProductProvider>(
                                      context,
                                      listen: false)
                                  .deleteItem(product.id!),
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
