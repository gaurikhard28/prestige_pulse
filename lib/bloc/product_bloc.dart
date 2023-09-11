import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prestige_pulse/Model/ProductModel.dart';

import '../Model/CartModel.dart';
import '../Services/request.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc({required this.productService}) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(
      ProductEvent event,
      ) async* {
    if (event is LoadProducts) {
      try {
        print('object');
        final List<Product> products = await productService.fetchProducts();
        yield ProductLoaded(products);
      } catch (e) {
        print('Error: $e');
        yield ProductError("Failed to load products");
      }
    }
  }
}
