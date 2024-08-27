import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/Error/failure.dart';
import '../../../../core/constant/constant.dart';
import '../model/grocery_model.dart';
import 'local_data_source.dart';

/// Abstract class representing the remote data source for the Ecommerce feature.
abstract class GroceryRemoteDataSource {
  /// Retrieves all groceries.
  Future<List<GroceryModel>> getAllGroceries();
  Future<GroceryModel> getGroceryById(String id);
}

/// Implementation of the [EcommerceRemoteDataSource] interface.
class GroceryRemoteDataSourceImpl implements GroceryRemoteDataSource {
  final http.Client client;
  final GroceryLocalDataSource groceryLocalDataSource;

  GroceryRemoteDataSourceImpl({
    required this.client,
    required this.groceryLocalDataSource,
  });

  @override
  Future<List<GroceryModel>> getAllGroceries() async {
    try {
      final response = await client.get(
      Uri.parse(GroceryApi.getAllGroceriesApi()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null) {
        return GroceryModel.getAllGroceries(data['data']);
      } else {
        throw Exception('Error no data source');
      }
    } else {
      throw const ConnectionFailur(message: 'server error');
    }
    } catch (e) {
      throw const ConnectionFailur(message: 'server error');
    }
    
  }

  @override
  Future<GroceryModel> getGroceryById(String id) async{
    try {
      final response = await client.get(
      Uri.parse(GroceryApi.getGroceryById(id)),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null) {
        return GroceryModel.fromJson(data['data']);
      } else {
        throw Exception('Error no data source');
      }
    } else {
      throw const ConnectionFailur(message: 'server error');
    }
    } catch (e) {
      throw const ConnectionFailur(message: 'server error');
    }
  }
}
