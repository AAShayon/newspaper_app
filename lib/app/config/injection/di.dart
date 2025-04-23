import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/network/api_client.dart';
import '../../core/network/dio_config.dart';


final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

void setupLocator() {
  // Register GetStorage
  GetStorage.init();
  locator.registerSingleton<GetStorage>(GetStorage());

  // Register DioService
  locator.registerSingleton<DioService>(DioService());


  // Register ApiClient
  locator.registerLazySingleton<ApiClient>(
      () => ApiClient(locator<DioService>().instance));

}
