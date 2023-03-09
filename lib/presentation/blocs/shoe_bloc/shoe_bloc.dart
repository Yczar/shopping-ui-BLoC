import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_ui/data/models/shoe.dart';

part 'shoe_event.dart';
part 'shoe_state.dart';

class ShoeBloc extends Bloc<ShoeEvent, ShoeState> {
  ShoeBloc() : super(ShoeInitial()) {
    on<ShoeEvent>(
      (event, emit) async {},
    );
    on<FetchShoesEvent>(_fetchShoesFromJson);
  }

  Future<void> _fetchShoesFromJson(
    ShoeEvent event,
    Emitter<ShoeState> emit,
  ) async {
    emit(ShoeStateLoading());
    try {
      final jsonData = await rootBundle.loadString(
        'assets/jsons/shoes.json',
      );
      await Future<dynamic>.delayed(
        const Duration(seconds: 1),
      );
      final data = (json.decode(jsonData) as Map)['shoes'] as List;
      final listOfShoes = data
          .map(
            (value) => Shoe.fromMap(value as Map<String, dynamic>),
          )
          .toList();
      emit(
        ShoeStateLoaded(
          shoes: listOfShoes,
        ),
      );
    } catch (e) {
      emit(
        ShoeStateError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
