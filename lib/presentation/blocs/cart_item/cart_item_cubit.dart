import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/presentation/cubits/cart_item/cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemInitial());
  int _cartItemCount = 0;

  void _updateCartItem(int newCount) {
    emit(CartItemLoading());
    _cartItemCount = newCount;
    emit(
      CartItemUpdated(cartItemCount: _cartItemCount),
    );
  }

  void incrementCartItem() {
    _updateCartItem(_cartItemCount + 1);
  }

  void decrementCartItem() {
    if (_cartItemCount < 0 || _cartItemCount == 0) return;
    _updateCartItem(_cartItemCount - 1);
  }
}
