import 'dart:convert';
import 'package:carecomm/core/networking/api_constant.dart';
import 'package:carecomm/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse(ApiConstants.apiBaseUrl));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
