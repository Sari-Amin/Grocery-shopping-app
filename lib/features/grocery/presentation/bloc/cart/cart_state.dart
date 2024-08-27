import 'package:flutter/cupertino.dart';

import '../../../Domain/entity/grocery_entity.dart';


@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<GroceryEntity> items;
  CartUpdatedState(this.items);
}

class CartEmpty extends CartState {}
