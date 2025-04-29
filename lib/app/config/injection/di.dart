import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newspaper_app/app/feature/auth/domain/usecases/sign_out.dart';
import '../../core/network/api_client.dart';
import '../../core/network/dio_config.dart';
import '../../feature/auth/data/datasources/auth_remote_datasource.dart';
import '../../feature/auth/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/domain/repositories/auth_repository.dart';
import '../../feature/auth/domain/usecases/get_user_info.dart';
import '../../feature/auth/domain/usecases/register_with_email.dart';
import '../../feature/auth/domain/usecases/sign_in_with_email.dart';
import '../../feature/auth/domain/usecases/sign_in_with_google.dart';
import '../../feature/auth/domain/usecases/update_password.dart';
import '../../feature/bookmark/data/datasources/bookmark_local_datasource.dart';
import '../../feature/bookmark/data/datasources/bookmark_remote_datasource.dart';
import '../../feature/bookmark/data/repositories/bookmark_repository_impl.dart';
import '../../feature/bookmark/domain/repositories/favorite_repository.dart';
import '../../feature/bookmark/domain/use_cases/get_bookmarks_use_case.dart';
import '../../feature/bookmark/domain/use_cases/remove_bookmark_use_case.dart';
import '../../feature/bookmark/domain/use_cases/save_bookmark_use_case.dart';
import '../../feature/home/data/datasources/news_remote_datasource.dart';
import '../../feature/home/data/repositories/news_repository_impl.dart';
import '../../feature/home/domain/repositories/news_repository.dart';
import '../../feature/home/domain/usecases/get_top_headlines.dart';
import '../../feature/settings/data/datasouces/theme_local_datasource.dart';
import '../../feature/settings/data/repositories/theme_repository_impl.dart';
import '../../feature/settings/domain/repositories/theme_repositories.dart';
import '../../feature/settings/domain/usecases/save_theme_preferences.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

Future<void> setupLocator() async {

  // initiateInternetChecker();
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
  locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
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
  locator.registerLazySingleton(
          () => SignOutUser(locator.get<AuthRepository>()));
  locator.registerLazySingleton(() => UpdatePassword(locator.get<AuthRepository>()));
  locator.registerLazySingleton(() => GetUserInfo(locator.get<AuthRepository>()));
  locator.registerLazySingleton<ThemeLocalDataSource>(
          () => ThemeLocalDataSource());

  // Register Repositories
  locator.registerLazySingleton<ThemeRepository>(
          () => ThemeRepositoryImpl(locator()));

  // Register Use Cases
  locator.registerLazySingleton(() => SaveThemePreference(locator()));

  locator.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(locator<ApiClient>()));
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(locator<NewsRemoteDataSource>()));
  locator.registerLazySingleton(() => GetTopHeadlines(locator.get<NewsRepository>()));

  locator.registerLazySingleton<BookmarkRemoteDataSource>(
        () => BookmarkRemoteDataSourceImpl(locator.get<FirebaseFirestore>()),
  );
  locator.registerLazySingleton<BookmarkLocalDataSource>(
        () => BookmarkLocalDataSourceImpl(),
  );

  // Register Bookmark Repository
  locator.registerLazySingleton<BookmarkRepository>(
        () => BookmarkRepositoryImpl(
      remoteDataSource: locator.get<BookmarkRemoteDataSource>(),
      localDataSource: locator.get<BookmarkLocalDataSource>(),
    ),
  );

  // Register Bookmark Use Cases
  locator.registerLazySingleton(() => SaveBookmarkUseCase(locator.get<BookmarkRepository>()));
  locator.registerLazySingleton(() => GetBookmarksUseCase(locator.get<BookmarkRepository>()));
  locator.registerLazySingleton(() => RemoveBookmarkUseCase(locator.get<BookmarkRepository>()));

  // Register Bookmark Controller

}
