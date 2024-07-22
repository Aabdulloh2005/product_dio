import 'dart:convert';

import 'package:lesson81_dio/data/models/category.dart';

class Product {
  final int id;
  String title;
  num price;
  String description;
  Category category;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] as int,
        title: map['title'] as String,
        price: map['price'] as num,
        description: map['description'] as String,
        category: Category.fromMap(map['category']),
        images: List<String>.from(
          (map['images']),
        ));
  }
}
