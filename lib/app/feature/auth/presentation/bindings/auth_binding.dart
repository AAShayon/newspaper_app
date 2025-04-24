import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../controllers/auth_controller.dart';


class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // Use cases
    Get.lazyPut(() => SignInWithGoogle(Get.find<AuthRepository>()));
    Get.lazyPut(() => SignInWithEmail(Get.find<AuthRepository>()));
    Get.lazyPut(() => RegisterWithEmail(Get.find<AuthRepository>()));

    // Controller
    Get.lazyPut(() => AuthController(
      signInWithGoogle: Get.find(),
      signInWithEmail: Get.find(),
      registerWithEmail: Get.find(),
    ));
  }
}