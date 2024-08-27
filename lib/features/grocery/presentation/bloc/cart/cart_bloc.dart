import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/entity/grocery_entity.dart';
import 'cart_event.dart';
import 'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  List<GroceryEntity> cartItems = [];

  CartBloc() : super(CartInitial());
  
}
