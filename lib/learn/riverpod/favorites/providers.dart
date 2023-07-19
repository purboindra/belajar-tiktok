import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final getAllProductsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  List<Map<String, dynamic>> tempData = [];
  final resp = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  final jsonResponse = jsonDecode(resp.body);
  for (final product in jsonResponse) {
    tempData.add({
      'id': product['id'],
      'title': product['title'],
      'price': product['price'],
      'category': product['category'],
      'description': product['description'],
      'image': product['image'],
      'isFavorite': false,
    });
  }
  return tempData;
});
