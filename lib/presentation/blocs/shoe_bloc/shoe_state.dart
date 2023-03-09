// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shoe_bloc.dart';

@immutable
abstract class ShoeState {}

@immutable
class ShoeInitial extends ShoeState {}

@immutable
class ShoeStateLoading extends ShoeState {}

@immutable
class ShoeStateLoaded extends ShoeState {
  final List<Shoe> shoes;
  ShoeStateLoaded({
    required this.shoes,
  });
}

@immutable
class ShoeStateError extends ShoeState {
  ShoeStateError({
    required this.errorMessage,
  });
  final String errorMessage;
}
