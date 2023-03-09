import 'package:equatable/equatable.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object?> get props => [];
}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemUpdated extends CartItemState {
  const CartItemUpdated({
    required this.cartItemCount,
  });

  final int cartItemCount;

  @override
  List<Object?> get props => [cartItemCount];
}
