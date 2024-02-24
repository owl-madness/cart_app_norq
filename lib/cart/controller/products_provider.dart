import 'dart:convert';

import 'package:cart_app_norq/main.dart';
import 'package:cart_app_norq/home/model/product_data_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductData> poductCartlist = [];
  bool isLoading = false;

  Future<void> initiateProductCartList() async {
    isLoading = true;
    notifyListeners();
    try {
      var dbJson = await dbHelper.queryAllRows();
      poductCartlist = List.generate(
          dbJson.length, (index) => ProductData.fromDBJson(dbJson[index]));
      print('poductCartlist len : ${poductCartlist.length}');
      isLoading = false;
    notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
    notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void addToCart(ProductData productData, BuildContext context) async {
    ProductData? tempProductData;
    for (var element in poductCartlist) {
      if (element.id == productData.id) {
        tempProductData = element;
        productData.quantity = productData.quantity + 1;
        int rowsAffected = await dbHelper.update(productData);
        print('rowsAffected : $rowsAffected');
        if (rowsAffected > 0) {
          initiateProductCartList();
          notifyListeners();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Added')));
        }
      }
    }
    if (tempProductData == null) {
      int insertedId = await dbHelper.insert(productData);
      print('insertedId : $insertedId');
      if (insertedId != null && insertedId > 0) {
        initiateProductCartList();
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Added')));
      }
    }
  }

  void deleteItem(int id) async {
    await dbHelper.delete(id);
    initiateProductCartList();
    notifyListeners();
  }

  void updateRowQuantity(
      ProductData productData, UpdateQuantityCase updateCase) async {
    switch (updateCase) {
      case UpdateQuantityCase.decrement:
        if (productData.quantity == 1) {
          print('productData id ${productData.id}');
          await dbHelper.delete(productData.id!);
          initiateProductCartList();
          notifyListeners();
        } else {
          productData.quantity = productData.quantity - 1;
          int rowsAffected = await dbHelper.update(productData);
          print('rowsAffected : $rowsAffected');
          initiateProductCartList();
          notifyListeners();
        }
        break;
      case UpdateQuantityCase.increment:
        productData.quantity = productData.quantity + 1;
        int rowsAffected = await dbHelper.update(productData);
        print('rowsAffected : $rowsAffected');
        initiateProductCartList();
        notifyListeners();
      default:
    }
  }
}

enum UpdateQuantityCase { increment, decrement }
