import 'dart:convert';

import 'package:equatable/equatable.dart';

class Shoe extends Equatable {
  const Shoe({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.inCart,
  });
  factory Shoe.fromJson(String source) =>
      Shoe.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      id: map['id'] as num,
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      color: map['color'] as String,
      inCart: map['inCart'] as bool,
    );
  }
  final num id;
  final String image;
  final String name;
  final String description;
  final num price;
  final String color;
  final bool inCart;

  Shoe copyWith({
    num? id,
    String? image,
    String? name,
    String? description,
    num? price,
    String? color,
    bool? inCart,
  }) {
    return Shoe(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      color: color ?? this.color,
      inCart: inCart ?? this.inCart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
      'inCart': inCart,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      name,
      description,
      price,
      color,
      inCart,
    ];
  }
}
