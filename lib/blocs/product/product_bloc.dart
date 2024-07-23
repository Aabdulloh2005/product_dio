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
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onGetProducts(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final products = await _productRepository.getProducts();

      emit(ProductLoaded(products: products));
    } catch (e) {
      print(ProductError(message: "Error on get:   $e"));

      emit(ProductError(message: "Error on Get :    $e"));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, emit) async {
    emit(ProductLoading());

    try {
      await _productRepository.addProduct(event.product);

      emit(ProductLoaded(products: await _productRepository.getProducts()));
    } catch (e) {
      emit(ProductError(message: "Error on Add:   $e"));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, emit) async {
    emit(ProductLoading());

    try {
      await _productRepository.updateProduct(event.product);

      emit(ProductLoaded(products: await _productRepository.getProducts()));
    } catch (e) {
      emit(ProductError(message: "Error on Edit:   $e"));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, emit) async {
    emit(ProductLoading());

    try {
      await _productRepository.deleteProduct(event.id);

      emit(ProductLoaded(products: await _productRepository.getProducts()));
    } catch (e) {
      emit(ProductError(message: "Error on delete$e"));
    }
  }
}
