import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/blocs/product/product_bloc.dart';
import 'package:lesson81_dio/core/app.dart';
import 'package:lesson81_dio/data/repositories/product_repository.dart';
import 'package:lesson81_dio/data/services/dio_product_service.dart';

void main(List<String> args) {
  final dioProductService = DioProductService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              ProductRepository(dioProductService: dioProductService),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              productRepository: context.read<ProductRepository>(),
            ),
          )
        ],
        child: const MainApp(),
      ),
    ),
  );
}
