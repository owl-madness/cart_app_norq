import 'dart:convert';

import 'package:cart_app_norq/cart/controller/products_provider.dart';
import 'package:cart_app_norq/home/model/product_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
    Future<List<ProductData>> fetchList(BuildContext context) async {
    try {
      Provider.of<ProductProvider>(context, listen: false).initiateProductCartList();
    } catch (e) {
      print('cartlist : $e');
    }
    List<ProductData> productlist = [];
    try {
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      print('resp: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        productlist =
            jsonList.map((json) => ProductData.fromJson(json)).toList();
      }
    } catch (e) {
      print('exception : $e');
    }
    return productlist;
  }

}