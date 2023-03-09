import 'package:flutter/material.dart';

import 'package:shopping_ui/data/models/shoe.dart';

class CartProvider extends ChangeNotifier {
  List<Shoe> _currentCartItems = [];
  List<Shoe> get currentCartItems => _currentCartItems;

  void updateCartItems(List<Shoe> items) {
    _currentCartItems = [...items];
    notifyListeners();
  }
}
