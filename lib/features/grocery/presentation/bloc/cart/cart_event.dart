import '../../../Domain/entity/grocery_entity.dart';

abstract class CartEvent {}

class AddItemEvent extends CartEvent {
  final GroceryEntity item;
  AddItemEvent(this.item);
}

class RemoveItemEvent extends CartEvent {
  final GroceryEntity item;
  RemoveItemEvent(this.item);
}

class ClearCartEvent extends CartEvent {}
