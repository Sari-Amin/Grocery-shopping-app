

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/usecase/grocery_usecase.dart';
import 'grocery_event.dart';
import 'grocery_state.dart';

class GroceryBloc  extends Bloc<GroceryEvent, GroceryState>{
  final GroceryUsecase groceryUsecase;

  GroceryBloc ({
    required this.groceryUsecase
  }):super(GroceryIntialState()){
   

    on<GetSingleGroceryEvent>(
      (event,emit) async{
        emit(LoadingState());
        final result = await groceryUsecase.getGroceryById(event.id);

        result.fold(
          (failure){
            
            emit(const GroceryErrorState(messages: 'try again'));
          },
          (data) {
            emit(LoadedSingleGroceryState(grocery: data));
          }
        );

      }
    );

    on<LoadAllGroceryEvent>(
      (event,emit) async{
        emit(LoadingState());
        final result = await groceryUsecase.displayAllGroceries();

        result.fold(
          (failure){
            
            emit(const GroceryErrorState(messages: 'try again'));
          },
          (data) {
            emit(LoadedAllGroceryState(groceries: data));
          }
        );

      }
    );
}
}