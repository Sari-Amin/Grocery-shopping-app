

import 'package:equatable/equatable.dart';
abstract class GroceryEvent  extends Equatable{
  const GroceryEvent ();

  @override
  List<Object ?> get props => [];
}

class LoadAllGroceryEvent extends GroceryEvent {
  const LoadAllGroceryEvent ();

  @override
  List<Object ?> get props => [];
}

class GetSingleGroceryEvent extends GroceryEvent {
  final String id;
  const GetSingleGroceryEvent({
    required this.id
  });
  @override
  List<Object ?> get props => [id];
}








