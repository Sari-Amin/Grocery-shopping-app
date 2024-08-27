import '../../../Domain/entity/grocery_entity.dart';



abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<GroceryEntity> items;
  CartUpdated(this.items);
}

class CartEmpty extends CartState {}
