import 'package:flutter/material.dart';

import 'package:shopping_ui/presentation/widgets/cart_list_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 1.5,
      width: 360,
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'Your Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 14,
              ),
              Expanded(
                child: CartListWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
