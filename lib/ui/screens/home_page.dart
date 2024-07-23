import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/ui/screens/manage_product_screen.dart';

import '../../blocs/product/product_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(GetProductEvent()),
        builder: (context, state) {
          print(state);
          if (state is ProductInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = (state as ProductLoaded).products;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              mainAxisExtent: 210,
            ),
            padding: const EdgeInsets.all(15),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ManageProductScreen(
                        isEdit: true,
                        product: product,
                      );
                    },
                  );
                },
                onDoubleTap: () {
                  context
                      .read<ProductBloc>()
                      .add(DeleteProductEvent(id: product.id.toString()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.network(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        product.images[0],
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image,
                            size: 150,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text("${product.price}\$"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ManageProductScreen(isEdit: false);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
