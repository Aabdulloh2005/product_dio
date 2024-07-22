import 'package:bloc/bloc.dart';
import 'package:lesson81_dio/data/repositories/product_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial()) {
    on<GetProductEvent>(_onGetProducts);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onGetProducts(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitial());
    try {
      final products = await _productRepository.getProducts();

      print(products);
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: "Error on Get :    $e"));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, emit) async {
    emit(ProductInitial());

    try {
      await _productRepository.addProduct(event.product);

      _onGetProducts(GetProductEvent(), emit);
    } catch (e) {
      emit(ProductError(message: "Error on ADD:   $e"));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, emit) async {
    emit(ProductInitial());

    try {
      await _productRepository.updateProduct(event.product);

      _onGetProducts(GetProductEvent(), emit);
    } catch (e) {
      emit(ProductError(message: "Error on ADD:   $e"));
    }
  }
}
