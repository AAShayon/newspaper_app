import 'dart:developer';

import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_user_info.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/sign_out.dart';

class AuthController extends GetxController {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;
  final AuthRepository authRepository;
  final SignOutUser signOutUser;
  final GetUserInfo getUserInfo;

  AuthController({
    required this.signInWithGoogle,
    required this.signInWithEmail,
    required this.registerWithEmail,
    required this.authRepository,
    required this.signOutUser,
    required this.getUserInfo,
  });

  Future<void> handleGoogleSignIn() async {
    final result = await signInWithGoogle.call();
    result.fold((failure) => Get.snackbar('Error', failure), (_) => NavigationService.navigateToUntilReplacement('/home'));
  }

  Future<void> handleEmailSignIn(String email, String password) async {
    final result = await signInWithEmail.call(email, password);
    result.fold((failure) => Get.snackbar('Error', failure), (_) => NavigationService.navigateToUntilReplacement('/home'));
  }

  Future<void> handleEmailRegister(String email, String password) async {
    final result = await registerWithEmail.call(email, password);
    result.fold((failure) => Get.snackbar('Error', failure), (_) => NavigationService.navigateToUntilReplacement('/home'));
  }
  bool isUserLoggedIn() {
    return authRepository.isUserLoggedIn();
  }
  Future<void> logout() async {
    final result = await signOutUser.call();
    result.fold(
          (failure) => Get.snackbar('Error', failure),
          (_) {
        NavigationService.navigateToUntilReplacement('/login');
        log("User logged out successfully");
      },
    );
  }
  Future<UserEntity?> fetchUserInfo() async {
    final result = await getUserInfo.call();
    return result.fold(
          (failure) {
        Get.snackbar('Error', failure);
        return null;
      },
          (userInfo) => userInfo,
    );
  }
}