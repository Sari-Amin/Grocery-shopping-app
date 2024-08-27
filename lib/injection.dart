import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/check_connectivity.dart';
import 'features/grocery/Data/data_source/local_data_source.dart';
import 'features/grocery/Data/data_source/remote_data_source.dart';
import 'features/grocery/Data/repositories/grocery_repo_impl.dart';
import 'features/grocery/Domain/repositories/grocery_repositories.dart';
import 'features/grocery/Domain/usecase/grocery_usecase.dart';
import 'features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // fearure - Grocery
  //bloc
  sl.registerFactory(() => GroceryBloc(groceryUsecase: sl()));
  //use cases
  sl.registerLazySingleton(() => GroceryUsecase(groceryRepositories: sl()));

  //repository
  sl.registerLazySingleton<GroceryRepositories>(() => GroceryRepoImpl(
        groceryRemoteDataSource: sl(),
        networkInfo: sl(),
        groceryLocalDataSource: sl(),
      ));
  //data scources
  sl.registerLazySingleton<GroceryRemoteDataSource>(
    () =>
        GroceryRemoteDataSourceImpl(client: sl(), groceryLocalDataSource: sl()),
  );

  sl.registerLazySingleton<GroceryLocalDataSource>(
    () => GroceryLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: sl(),
    ),
  );
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
