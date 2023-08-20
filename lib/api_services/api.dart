import 'dart:convert';

import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<ProductModel>> getProducts() async {
    final List<ProductModel> dataList = [];
    try {
      var response =
          await http.get(Uri.parse("https://dummyjson.com/products"));
      var decodeJson = json.decode(response.body);

      List dList = decodeJson['products'];
      for (var d in dList) {
        final ProductModel model = ProductModel.fromJson(d);
        dataList.add(model);
      }

      return dataList;
    } catch (e) {
      print(e);
      return dataList;
    }
  }

  Future<ProductModel?> getProductDetails(int? id) async {
    ProductModel? productModel;
    try {
      var response = await http
          .get(Uri.parse("https://dummyjson.com/products/${id ?? 1}"));
      var decodeJson = json.decode(response.body);
      final ProductModel model = ProductModel.fromJson(decodeJson);
      productModel = model;
    } catch (e) {
      print(e);
    }
    return productModel;
  }
}
