
class GroceryApi {
  static String getAllGroceriesApi() =>
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries';
  static String getGroceryById(String id) =>
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries/$id';
}
