import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/blocs/product/product_bloc.dart';
import 'package:lesson81_dio/data/models/product.dart';

import '../../data/models/category.dart';

class ManageProductScreen extends StatefulWidget {
  final bool isEdit;
  final Product? product;

  const ManageProductScreen({super.key, required this.isEdit, this.product});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  double _price = 0.0;
  String _description = '';
  String _categoryName = '';
  String _categoryImage = '';
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      _title = widget.product!.title;
      _price = widget.product!.price.toDouble();
      _description = widget.product!.description;
      _categoryName = widget.product!.category.name;
      _categoryImage = widget.product!.category.image;
      _images = widget.product!.images;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.isEdit ? 'Edit Product' : 'Add Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _price = double.parse(value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _description,
              decoration: const InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _categoryName,
              decoration: const InputDecoration(labelText: 'Category Name'),
              onSaved: (value) => _categoryName = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _categoryImage,
              decoration:
                  const InputDecoration(labelText: 'Category Image URL'),
              onSaved: (value) => _categoryImage = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category image URL';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _images.toString(),
              decoration: const InputDecoration(
                  labelText: 'Images (comma-separated URLs)'),
              onSaved: (value) =>
                  _images = value!.split(',').map((e) => e.trim()).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image URLs';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              !widget.isEdit
                  ? context.read<ProductBloc>().add(
                        AddProductEvent(
                          product: Product(
                            id: DateTime.now().millisecondsSinceEpoch,
                            title: _title,
                            price: _price,
                            description: _description,
                            category: Category(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: _categoryName,
                              image: _categoryImage,
                            ),
                            images: _images,
                          ),
                        ),
                      )
                  : context.read<ProductBloc>().add(
                        UpdateProductEvent(
                          product: Product(
                            id: widget.product!.id,
                            title: _title,
                            price: _price,
                            description: _description,
                            category: Category(
                              id: widget.product!.id,
                              name: _categoryName,
                              image: _categoryImage,
                            ),
                            images: _images,
                          ),
                        ),
                      );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
