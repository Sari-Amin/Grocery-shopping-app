


import 'package:equatable/equatable.dart';
import '../../../Domain/entity/grocery_entity.dart';

abstract class GroceryState extends Equatable{
  const GroceryState();

  @override
  List<Object ?> get props => [];
}

class GroceryIntialState extends GroceryState {}

class LoadedSingleGroceryState extends GroceryState {
  final GroceryEntity grocery;

  const LoadedSingleGroceryState ({
    required this.grocery
  });

  @override
  List<Object ?> get props => [grocery];
}

class LoadedAllGroceryState extends GroceryState {
  final List<GroceryEntity> groceries;

  const LoadedAllGroceryState ({
    required this.groceries,
  });

  @override

  List<Object ?> get props => [groceries]; 
}




class GroceryErrorState extends GroceryState {
  final String messages;

  const GroceryErrorState ({
    required this.messages
  });

  @override
  List<Object ?> get props => [messages];
}




class LoadingState extends GroceryState {}

