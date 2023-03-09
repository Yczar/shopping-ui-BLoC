import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/presentation/blocs/shoe_bloc/shoe_bloc.dart';
import 'package:shopping_ui/presentation/screens/home_screen.dart';
import 'package:shopping_ui/presentation/widgets/add_to_cart_button.dart';

import 'package:shopping_ui/utils/helper.dart';

import '../../utils/hex_color.dart';

class PendingItemWidget extends StatefulWidget {
  const PendingItemWidget({super.key});

  @override
  State<PendingItemWidget> createState() => _PendingItemWidgetState();
}

/// This widget displays the list of pending items. It receives a [ShoeBloc]
///  and renders the items based on its state. When the state is
/// [ShoeStateLoading], it displays a loading indicator. When the state is
/// [ShoeStateLoaded], it displays the list of shoes with their details.
class _PendingItemWidgetState extends State<PendingItemWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ShoeBloc, ShoeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: size.height / 1.8,
                  width: 360,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.1),
                    child: Builder(
                      builder: (context) {
                        if (state is ShoeStateLoading) {
                          return const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.purple,
                              ),
                            ),
                          );
                        } else if (state is ShoeStateLoaded) {
                          return ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Picked Items',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    ...state.shoes.map(
                                      (shoe) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 24,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 380,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: HexColor.fromHex(
                                                  shoe.color,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  30,
                                                ),
                                              ),
                                              child: Transform.rotate(
                                                angle:
                                                    Helper.degreeToRadian(-24),
                                                child: Image.network(
                                                  shoe.image,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              shoe.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              shoe.description,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$${shoe.price}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                AddToCartButton(shoe),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return const Offstage();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
