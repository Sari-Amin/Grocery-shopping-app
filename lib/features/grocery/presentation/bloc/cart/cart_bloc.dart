

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/entity/grocery_entity.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<GroceryEntity> _cartItems = [];

  CartBloc() : super(CartInitial());

  on<AddItemEvent>((event, emit) {
      _cartItems.add(event.item);
      emit(CartUpdatedState(cartItems: _cartItems));
      return;
  });
  on<RemoveItemEvent>((event, emit) {
    _cartItems.remove(event.item);
    emit(CartUpdatedState(cartItems: _cartItems));
      return;

  });

  on<ClearCartEvent>((event, emit) {
      _cartItems.clear();
      return emit(CartUpdatedState(cartItems: _cartItems));
      return;
    });

  on<GetAllCartEvent>((event, emit) {
      emit(CartUpdatedState(cartItems: _cartItems));
      return;

    });
}
