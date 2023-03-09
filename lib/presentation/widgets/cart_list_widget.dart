import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import 'package:shopping_ui/data/models/shoe.dart';
import 'package:shopping_ui/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/presentation/providers/cart_provider.dart';
import 'package:shopping_ui/presentation/widgets/cart_item_widget.dart';

class CartListWidget extends StatefulWidget {
  const CartListWidget({super.key});

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

/// This is the state of the _CartListWidget widget.
/// It holds a list of [Shoe] items and a [GlobalKey] for the
/// [AnimatedList] widget.
class _CartListWidgetState extends State<CartListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Shoe> _items = [];

  @override
  Widget build(BuildContext context) {
    return Nested(
      // Nest this widget in the [CartPage] widget
      children: [
        BlocListener<CartBloc, CartState>(
          // Listen to changes in the [CartBloc] state
          listener: (context, state) {
            if (state is CartItemAdded) {
              // If a new item has been added to the cart
              _addItem(state.shoe); // Add the new item to the [_items] list
              context.read<CartProvider>().updateCartItems(
                    _items,
                  ); // Update the cart items in the [CartProvider]
              context
                  .read<CartBloc>()
                  .add(ResetCartBlocEvent()); // Reset the [CartBloc] state
            } else if (state is CartItemRemoved) {
              // If an item has been removed from the cart
              context.read<CartProvider>().updateCartItems(
                    _items,
                  ); // Update the cart items in the [CartProvider]
              context
                  .read<CartBloc>()
                  .add(ResetCartBlocEvent()); // Reset the [CartBloc] state
            } else if (state is CartInitial) {}
          },
        )
      ],
      child: ScrollConfiguration(
        // Configure scrolling behavior of the [AnimatedList]
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false, // Hide the scrollbar
        ),
        child: AnimatedList(
          // The list of [CartItemWidget]s in the cart
          key: _listKey,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation) {
            return CartItemWidget(
              // Return a [CartItemWidget] for each item in [_items]
              _items[index],
              animation,
              onRemoveItem: () => _removeItem(
                _items[index],
              ), // When the remove button is pressed, remove the item from
              // the cart
            );
          },
        ),
      ),
    );
  }

  /// This method adds a [Shoe] item to the [_items] list and inserts a new [
  /// CartItemWidget] into the [AnimatedList].
  void _addItem(Shoe shoe) {
    final index = _items.length;
    _items.add(shoe);
    _listKey.currentState!.insertItem(index);
  }

  /// This method removes a [Shoe] item from the [_items] list and removes the
  /// corresponding [CartItemWidget] from the [AnimatedList].
  void _removeItem(Shoe shoe) {
    final index = _items.indexOf(shoe);
    _items.removeAt(index);
    context.read<CartBloc>().add(
          RemoveItemFromCartEvent(
            shoe: shoe,
          ),
        ); // Remove the item from the cart in the [CartBloc]
    _listKey.currentState!.removeItem(
      // Remove the [CartItemWidget] from the [AnimatedList]
      index,
      (context, animation) {
        return CartItemWidget(shoe, animation);
      },
    );
  }
}
