import 'dart:core';

import '../../Domain/entity/grocery_entity.dart';

class GroceryModel extends GroceryEntity {
  const GroceryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.discount,
    required super.options,
    required super.rating,
  });

  factory GroceryModel.fromJson(dynamic json) => GroceryModel(
      id: json['id'],
      rating: json['rating'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      discount: json['discount'],
      options: OptionModel.getAllOptions(json['options']));

  static List<GroceryModel> getAllGroceries(dynamic jsons) {
    List<GroceryModel> groceries = [];
    for (dynamic product in jsons['data']) {
      groceries.add(GroceryModel.fromJson(product));
    }
    return groceries;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
        'discount': discount,
        'options': options
      };

  GroceryEntity toEntity() => GroceryEntity(
      id: id,
      rating: rating,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      discount: discount,
      options: options);
  static List<GroceryEntity> listToEntity(List<GroceryModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}

class OptionModel extends OptionEntity {
  OptionModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        id: json['messageId'],
        name: json['messages'],
        price: json['price'],
      );
  static List<OptionModel> getAllOptions(dynamic jsons) {
    List<OptionModel> options = [];
    for (dynamic product in jsons['data']) {
      options.add(OptionModel.fromJson(product));
    }
    return options;
  }
  OptionEntity toEntity() => OptionEntity(
        id: id,
        name: name,
        price: price,
      );
}
