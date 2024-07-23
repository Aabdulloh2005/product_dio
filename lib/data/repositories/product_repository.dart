import 'package:dio/dio.dart';
import 'package:lesson81_dio/data/models/product.dart';
import 'package:lesson81_dio/data/services/dio_product_service.dart';

class ProductRepository {
  final DioProductService _dioProductService;

  ProductRepository({required DioProductService dioProductService})
      : _dioProductService = dioProductService;

  Future<List<Product>> getProducts() async {
    return await _dioProductService.getProducts();
  }

  Future<Product> addProduct(Product product) async {
    return await _dioProductService.addProduct(product);
  }

  Future<Product> updateProduct(Product product) async {
    return _dioProductService.updateProduct(product);
  }

  Future<Response> deleteProduct(String id) async {
    return await _dioProductService.deleteProduct(id);
  }
}
