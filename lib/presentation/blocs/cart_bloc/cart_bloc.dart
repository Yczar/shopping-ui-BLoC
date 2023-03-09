import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_ui/data/models/shoe.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddItemToCartEvent>(_addItemToCart);
    on<RemoveItemFromCartEvent>(_removeItemFromCart);
    on<ResetCartBlocEvent>((event, emit) {
      emit(CartInitial());
    });
  }
  final List<Shoe> cartItems = [];

  void _addItemToCart(AddItemToCartEvent event, Emitter<CartState> emit) {
    if (cartItems.contains(event.shoe)) {
      return;
    }
    emit(CartLoading());
    cartItems.add(event.shoe);
    emit(CartItemAdded(shoe: event.shoe));
  }

  void _removeItemFromCart(
    RemoveItemFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoading());
    cartItems.remove(event.shoe);
    emit(CartItemRemoved(shoe: event.shoe));
  }
}
