

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


class DeleteGroceryEvent extends GroceryEvent {
  final String id;
  const DeleteGroceryEvent({
    required this.id
  });
  @override
  List<Object ?> get props => [id];
}


class CreateGroceryEvent extends GroceryEvent {
  final String ecommerceEntity;
  const CreateGroceryEvent({
    required this.ecommerceEntity
  });
  @override
  List<Object ?> get props => [ecommerceEntity];
}








