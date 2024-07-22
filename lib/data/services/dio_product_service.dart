import 'package:dio/dio.dart';
import 'package:lesson81_dio/core/network/dio_client.dart';
import 'package:lesson81_dio/data/models/product.dart';

class DioProductService {
  final _dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dioClient.get(url: "/products");

      List<Product> products = [];
      for (var i in response.data) {
        products.add(Product.fromMap(i));
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> addProduct(Product product) async {
    try {
      final response =
          await _dioClient.add(url: "/products", data: product.toMap());

      return Product.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await _dioClient.update(
          url: "/products/${product.id}", data: product.toMap());

      return Product.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteProduct(String id) async {
    try {
      final response = await _dioClient.delete(url: "/products/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
