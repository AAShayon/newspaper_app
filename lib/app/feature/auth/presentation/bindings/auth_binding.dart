import 'package:get/get.dart';
import 'package:newspaper_app/app/feature/auth/domain/usecases/get_user_info.dart';
import 'package:newspaper_app/app/feature/auth/domain/usecases/sign_out.dart';
import '../../../../config/injection/di.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../controllers/auth_controller.dart';


class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(
      authRepository: locator.get<AuthRepository>(),
      signInWithGoogle: locator.get<SignInWithGoogle>(),
      signInWithEmail: locator.get<SignInWithEmail>(),
      registerWithEmail: locator.get<RegisterWithEmail>(),
      signOutUser: locator.get<SignOutUser>(),
      getUserInfo: locator.get<GetUserInfo>()
    ));
  }
}