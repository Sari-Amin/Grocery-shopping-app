import 'package:equatable/equatable.dart';

import '../../Data/model/grocery_model.dart';

class GroceryEntity extends Equatable {
  const GroceryEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.discount,
    required this.imageUrl,
    required this.options,
    required this.description,
  });
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double discount;
  final List<OptionEntity> options;
  final double rating;

  GroceryModel toModel() => GroceryModel(
        id: id,
        rating: rating,
        name: name,
        description: description,
        imageUrl: imageUrl,
        price: price,
        discount: discount,
        options: options,
      );
  @override
  List<Object?> get props =>
      [id, name, description, imageUrl, price, discount, options, rating];
}

class OptionEntity {
  final String id;
  final String name;
  final double price;

  OptionEntity({
    required this.id,
    required this.name,
    required this.price,
  });
}
