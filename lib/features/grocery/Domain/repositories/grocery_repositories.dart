
import 'package:dartz/dartz.dart';
import '../../../../core/Error/failure.dart';
import '../entity/grocery_entity.dart';

abstract class GroceryRepositories{

  Future<Either<Failure,List<GroceryEntity>>> getAllGroceries();
  Future<Either<Failure,GroceryEntity>> getSingleGrocery(String id);

}