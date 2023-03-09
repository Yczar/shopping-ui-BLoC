import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_ui/data/models/shoe.dart';

import 'package:shopping_ui/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/presentation/providers/cart_provider.dart';

/// A button widget that adds or removes a shoe from the cart.
class AddToCartButton extends StatelessWidget {
  /// Constructs an [AddToCartButton] with the given [shoe].
  const AddToCartButton(
    this.shoe, {
    super.key,
  });

  /// The [Shoe] to add or remove from the cart.
  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, List<Shoe>>(
      selector: (_, provider) => provider.currentCartItems,
      builder: (context, shoes, __) {
        return AnimatedSwitcher(
          duration: const Duration(
            seconds: 2,
          ),
          switchInCurve: Curves.bounceIn,
          switchOutCurve: Curves.bounceOut,
          child: shoes.contains(
            shoe,
          )
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    backgroundColor: Colors.purple,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.check,
                    size: 18,
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(
                          AddItemToCartEvent(
                            shoe: shoe,
                          ),
                        );
                  },
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
