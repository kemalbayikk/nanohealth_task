import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nanohealth_task/model/product/product_model.dart';
import 'package:nanohealth_task/model/product/rating_model.dart';
import 'package:nanohealth_task/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  bool isLoading = true;
  List<ProductModel> products = [];
  ProductModel? selectedProduct;

  setSelectedProduct(ProductModel product) {
    selectedProduct = product;
  }

  getAllProducts() async {
    var url = Uri.parse('${Constants.API_URL}products');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      List<dynamic>? responseList =
          responseJson != null ? List.from(responseJson) : null;

      for (var element in responseList!) {
        products.add(ProductModel(
            id: element["id"],
            title: element["title"],
            price: element["price"],
            category: element["category"],
            image: element["image"],
            description: element["description"],
            rating: RatingModel(
                count: element["rating"]["count"],
                rate: element["rating"]["rate"])));
      }

      isLoading = false;
      notifyListeners();
    }
  }
}
