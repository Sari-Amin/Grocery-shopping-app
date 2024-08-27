import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/Error/failure.dart';
import '../model/grocery_model.dart';

abstract class GroceryLocalDataSource{
  Future<List<GroceryModel>> getAllFromLocal();
  Future<GroceryModel> getSingleGrocery(String id);
  Future<bool> addCach(GroceryModel data);
  Future<bool> deleteCach(String id);
}
// ignore: constant_identifier_names
const String CHACHED_GROCERY  = 'CACHED_GROCERY';

class GroceryLocalDataSourceImpl implements GroceryLocalDataSource{

  final SharedPreferences sharedPreferences;
  const GroceryLocalDataSourceImpl({
    required this.sharedPreferences
  });

  @override
  Future<List<GroceryModel>> getAllFromLocal() {
    final jsonString = sharedPreferences.getString(CHACHED_GROCERY);
    if (jsonString != null) {
      final result = json.decode(jsonString);
    return Future.value(GroceryModel.getAllGroceries(result));

    }
    else {
      
      throw const CachException(message: 'No data found');
    }
  }

  @override
  Future<GroceryModel> getSingleGrocery(String id) {

    final jsonString = sharedPreferences.getString(CHACHED_GROCERY);
    try {
    if (jsonString != null) {
      final jsons = json.decode(jsonString);

      final result = GroceryModel.fromJson(jsons['data']);

      return Future.value(result);
    }
    else {
      throw const CachException(message: 'No data found');
    }
    } catch (e) {

      throw const CachException(message: 'No data found');
     
      }
  }
  
  @override
  Future<bool> addCach(GroceryModel data) {
    try {
      final jsonString = sharedPreferences.getString(CHACHED_GROCERY);
      if (jsonString != null) {
        final List<dynamic> existingData = json.decode(jsonString);
        existingData.add(data.toJson());
        final updatedJsonString = json.encode(existingData);
        return sharedPreferences.setString(CHACHED_GROCERY, updatedJsonString);
      
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }
  
  @override
  Future<bool> deleteCach(String id) async{
    try{
      
      List<GroceryModel> products =  await getAllFromLocal();
      
      List<GroceryModel> newProducts = [];
      for (GroceryModel product in products) {
        if (product.id != id) {
          newProducts.add(product);
        }
      }
      return sharedPreferences.setString(CHACHED_GROCERY, json.encode(newProducts));
    } catch (e) {
      return Future.value(false);
    }
  }
  

  
}


