import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/presentation/blocs/shoe_bloc/shoe_bloc.dart';
import 'package:shopping_ui/presentation/widgets/cart_widget.dart';
import 'package:shopping_ui/presentation/widgets/margins/x_margin.dart';
import 'package:shopping_ui/presentation/widgets/pending_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    context.read<ShoeBloc>().add(FetchShoesEvent());
    _animation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    )..addListener(() {
        if (_animation.status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (_animation.status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, __) {
              return AnimatedPositioned(
                bottom: -(size.height / 1.5) + _animation.value,
                left: -(size.width / 3.2),
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.bounceInOut,
                child: Transform.scale(
                  scale: 3.5,
                  child: Container(
                    width: size.width * 2,
                    height: size.height / 1.8,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              PendingItemWidget(),
              XMargin(20),
              CartWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
