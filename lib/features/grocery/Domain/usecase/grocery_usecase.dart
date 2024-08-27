
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Error/failure.dart';
import '../entity/grocery_entity.dart';
import '../repositories/grocery_repositories.dart';

class GroceryUsecase extends Equatable {

    final GroceryRepositories groceryRepositories;
    const GroceryUsecase ({
      required this.groceryRepositories
    });

    // feach all data from APi
    Future<Either<Failure,List<GroceryEntity>>> displayAllGroceries() {
      return  groceryRepositories.getAllGroceries();
    }
    //fetch single 
    Future<Either<Failure,GroceryEntity>> getGroceryById(String id) {
      return  groceryRepositories.getSingleGrocery(id);
    }

    // // get data by id
    // Future<Either<Failure,EcommerceEntity>> dataById(String id) {
    //   return repositories.getProductById(id);
    // }

    // // edit the product
    // Future<Either<Failure,bool>> editProduct(String id, Map<String,dynamic> jsonString ){
    //    return repositories.editeProduct(id, jsonString);
    // }

    // // delte product 
    // Future<Either<Failure,bool>> deleteProduct(String id){
    //   return repositories.deleteProduct(id);
    // }

    // // add new product 
    // Future<Either<Failure,bool>> addProducts(Map<String,dynamic> jsonString ){

    //   return repositories.addProduct(jsonString);
    // }

    // Future<Either<Failure, Map<String,dynamic>>> selectImage(){
    //   return repositories.selectImage();
    // }

    // Future<String> getName(String key){
    //   return repositories.getUserName(key);
    // }

    // Future<bool> deleteToken(String key){
    //   return repositories.logoutUser(key);
    // }

    @override
 
    List<Object?> get props => throw UnimplementedError();
  
}