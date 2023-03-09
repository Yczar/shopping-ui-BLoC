// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

@immutable
class CartLoading extends CartState {}

@immutable
class CartItemAdded extends CartState {
  const CartItemAdded({
    required this.shoe,
  });

  final Shoe shoe;

  @override
  List<Object?> get props => [shoe];
}

@immutable
class CartItemRemoved extends CartState {
  const CartItemRemoved({
    required this.shoe,
  });

  final Shoe shoe;

  @override
  List<Object?> get props => [shoe];
}
