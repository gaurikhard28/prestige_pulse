import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestige_pulse/Model/ProductModel.dart';


// class ProductService{
//    Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
//     if (response.statusCode == 200) {
//       final productsJson = jsonDecode(response.body);
//       //print(productsJson.map((json) => Product.fromJson(json)).toList());
//       return  productsJson.map((json) => Product.fromJson(json)).toList();
//
//     }
//     else {
//       print(response.reasonPhrase);
//       throw Exception('Failed to load products');
//     }
//   }
// }


class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = jsonDecode(response.body);
      List<Product> products = productsJson.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
