
import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../../../../core/network/check_connectivity.dart';
import '../../Domain/entity/grocery_entity.dart';
import '../../Domain/repositories/grocery_repositories.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../model/grocery_model.dart';

class GroceryRepoImpl implements GroceryRepositories {
  final GroceryRemoteDataSource groceryRemoteDataSource;
  final NetworkInfo networkInfo;
  final GroceryLocalDataSource groceryLocalDataSource;
  const GroceryRepoImpl(
      {required this.groceryRemoteDataSource,
      required this.networkInfo,
      required this.groceryLocalDataSource});


  @override
  Future<Either<Failure, List<GroceryEntity>>> getAllGroceries() async {
    try {
      final connection = await networkInfo.isConnected;
      if (connection == false) {
        return const Left(ConnectionFailur(message: 'connection error'));
      }
      final result = await groceryRemoteDataSource.getAllGroceries();
      final entities = GroceryModel.listToEntity(result);
      return Right(entities);
    } on ServerFailure {
      return const Left(ServerFailure(message: 'server Error'));
    } on ConnectionFailur {
      return const Left(ConnectionFailur(message: 'Connection Error'));
    }
  }

  @override
  Future<Either<Failure, GroceryEntity>> getSingleGrocery(String id) async{
      try {
      final connection = await networkInfo.isConnected;
      if (connection == false) {
        return const Left(ConnectionFailur(message: 'connection error'));
      }
      final result = await groceryRemoteDataSource.getGroceryById(id);
      return Right(result.toEntity());
    } on ServerFailure {
      return const Left(ServerFailure(message: 'server Error'));
    } on ConnectionFailur {
      return const Left(ConnectionFailur(message: 'Connection Error'));
    }
  }
}
