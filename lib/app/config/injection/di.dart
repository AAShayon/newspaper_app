import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/network/api_client.dart';
import '../../core/network/dio_config.dart';
import '../../core/utils/helper/helper_methods.dart';
import '../../feature/auth/data/datasources/auth_remote_datasource.dart';
import '../../feature/auth/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/domain/repositories/auth_repository.dart';
import '../../feature/auth/domain/usecases/register_with_email.dart';
import '../../feature/auth/domain/usecases/sign_in_with_email.dart';
import '../../feature/auth/domain/usecases/sign_in_with_google.dart';
import '../firebase_configuration/firebase_config.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

Future<void> setupLocator() async{
  await FirebaseConfig.initialize();
  initiateInternetChecker();
  // Register GetStorage
  await GetStorage.init();
  locator.registerSingleton<GetStorage>(GetStorage());

  // Register DioService
  locator.registerSingleton<DioService>(DioService());

  // Register ApiClient
  locator.registerLazySingleton<ApiClient>(
      () => ApiClient(locator<DioService>().instance));
  // Register Firebase Auth and Google Sign-In
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Register AuthRemoteDataSource
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            locator<FirebaseAuth>(),
            locator<GoogleSignIn>(),
          ));

  // Register AuthRepository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        locator<AuthRemoteDataSource>(),
      ));
  // Use cases
  locator.registerLazySingleton(
      () => SignInWithGoogle(locator.get<AuthRepository>()));
  locator.registerLazySingleton(
      () => SignInWithEmail(locator.get<AuthRepository>()));
  locator.registerLazySingleton(
      () => RegisterWithEmail(locator.get<AuthRepository>()));
}
