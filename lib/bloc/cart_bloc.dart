import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_pulse/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/CartModel.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    // Load saved cart items from SharedPreferences
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? cartItemsJson = sharedPreferences.getString("cartItems");

    if (cartItemsJson != null) {
      List<dynamic> cartItemsData = jsonDecode(cartItemsJson);
      _cartItems = List<CartItem>.from(
        cartItemsData.map((item) => CartItem.fromJson(item)),
      );

      // Emit a CartUpdated state to notify the UI about the loaded items
      emit(CartUpdated(List.from(_cartItems)));
    }
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      bool alreadyInCart = false;
      for (var item in _cartItems) {
        if (item.product.id == event.product.id) {
          item.quantity++;
          alreadyInCart = true;
          break;
        }
      }

      if (!alreadyInCart) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        _cartItems.add(CartItem(product: event.product));
        print(_cartItems);
        sharedPreferences.setString("cartItems", jsonEncode(_cartItems));
      }
      yield CartUpdated(List.from(_cartItems));
    }
    else if (event is RemoveFromCart) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      _cartItems.removeWhere((item) => item.product.id == event.product.id);
      print(_cartItems);
      sharedPreferences.setString("cartItems", jsonEncode(_cartItems));
      yield CartUpdated(List.from(_cartItems));
    }
  }
}