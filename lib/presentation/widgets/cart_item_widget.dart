import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shopping_ui/data/models/shoe.dart';
import 'package:shopping_ui/presentation/cubits/cart_item/cart_item_cubit.dart';
import 'package:shopping_ui/presentation/cubits/cart_item/cart_item_state.dart';
import 'package:shopping_ui/presentation/widgets/margins/y_margin.dart';
import 'package:shopping_ui/utils/helper.dart';
import 'package:shopping_ui/utils/hex_color.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget(
    this.shoe,
    this.animation, {
    super.key,
    this.onRemoveItem,
  });
  final Shoe shoe;
  final Animation<double> animation;
  final VoidCallback? onRemoveItem;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget>
    with TickerProviderStateMixin {
  late CartItemCubit _cartItemCubit;
  late AnimationController _controller;
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _animation;
  late Animation<double> _animation1;
  late Animation<Offset> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    // Initialize the CartItemCubit to increment cart item count
    _cartItemCubit = CartItemCubit()..incrementCartItem();

    // Create animation controllers with durations of 400ms,
    // 100ms and 200ms respectively
    _controller = _createAnimationController(400);
    _controller1 = _createAnimationController(100);
    _controller2 = _createAnimationController(200);

    // Create animations using Tween with specific begin and end values
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation1 = Tween<double>(begin: 0, end: 1).animate(_controller1);
    _animation2 = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(_controller2);
    _animation3 = Tween<double>(begin: 0, end: 1).animate(_controller2);

    // Initialize and start animations
    _initAnimations();
  }

  // Function to create AnimationControllers
  AnimationController _createAnimationController(int milliseconds) {
    return AnimationController(
      vsync: this,
      duration: Duration(milliseconds: milliseconds),
    );
  }

  // Function to initialize and start animations
  void _initAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller1.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _controller2.forward();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose animation controllers to free up resources
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;
    final animation = widget.animation;
    return ScaleTransition(
      scale: animation,
      alignment: Alignment.centerLeft,
      child: BlocProvider.value(
        value: _cartItemCubit,
        child: Nested(
          children: [
            BlocListener<CartItemCubit, CartItemState>(
              listener: (_, state) {
                if (state is CartItemUpdated &&
                    state.cartItemCount == 0 &&
                    widget.onRemoveItem != null) {
                  widget.onRemoveItem!();
                  return;
                }
              },
            )
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: UnconstrainedBox(
                          child: ScaleTransition(
                            scale: _animation,
                            child: CircleAvatar(
                              backgroundColor: HexColor.fromHex(shoe.color),
                              radius: 30,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: Transform.rotate(
                            angle: Helper.degreeToRadian(-24),
                            child: ScaleTransition(
                              scale: _animation1,
                              child: Image.network(
                                shoe.image,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: _animation2,
                          child: FadeTransition(
                            opacity: _animation3,
                            child: Text(
                              shoe.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SlideTransition(
                          position: _animation2,
                          child: FadeTransition(
                            opacity: _animation3,
                            child: Text(
                              '\$${shoe.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SlideTransition(
                          position: _animation2,
                          child: FadeTransition(
                            opacity: _animation3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _cartItemCubit.decrementCartItem();
                                  },
                                  icon: const Icon(Icons.chevron_left_rounded),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                BlocBuilder<CartItemCubit, CartItemState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is CartItemUpdated
                                          ? state.cartItemCount.toString()
                                          : '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _cartItemCubit.incrementCartItem();
                                  },
                                  icon: const Icon(
                                    Icons.chevron_right_rounded,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const YMargin(5),
              FadeTransition(
                opacity: _animation3,
                child: const Divider(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
