import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/entity/grocery_entity.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<GroceryEntity> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddItemEvent>((event, emit) {
      _cartItems.add(event.item);
      emit(CartUpdatedState(_cartItems));
      return;
    });
    on<RemoveItemEvent>((event, emit) {
      _cartItems.remove(event.item);
      emit(CartUpdatedState(_cartItems));
      return;
    });

    on<ClearCartEvent>((event, emit) {
      _cartItems.clear();
      return emit(CartUpdatedState(_cartItems));
    });

    on<GetAllCartEvent>((event, emit) {
      emit(CartUpdatedState(_cartItems));
      return;
    });
  }
}
