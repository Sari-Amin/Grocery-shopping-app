
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    GroceryReposito,
    EcommerceRemoteDataSourceImpl,
    NetworkInfoImpl,
    InternetConnectionChecker,
    SharedPreferences,
    LocalDataSourceImpl,
    EcommerceUsecase,
    ProductBloc,
    ImageBloc,
    ButtonBloc,
    LoginRepositories,
    LoginRepoImpl,
    RemoteDatasourceImpl,
    LoginUserStatesBloc,
    LoginUseCase,
    LoginBloc,
    LoginRegistrationBloc,
    ChatUsecase,
    ChatRemoteDataImpl,
    ChatLocalDataImpl,
    ChatRepositories,
    ChatRepoImpl,
    ChatBloc
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
@GenerateMocks([http.Client])
void main() {}
