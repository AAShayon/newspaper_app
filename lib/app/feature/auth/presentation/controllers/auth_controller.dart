import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/register_with_email.dart';

class AuthController extends GetxController {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;
  final AuthRepository authRepository;

  AuthController({
    required this.signInWithGoogle,
    required this.signInWithEmail,
    required this.registerWithEmail,
    required this.authRepository,
  });

  Future<void> handleGoogleSignIn() async {
    final result = await signInWithGoogle.call();
    result.fold((failure) => Get.snackbar('Error', failure), (_) => Get.toNamed('/home'));
  }

  Future<void> handleEmailSignIn(String email, String password) async {
    final result = await signInWithEmail.call(email, password);
    result.fold((failure) => Get.snackbar('Error', failure), (_) => Get.toNamed('/home'));
  }

  Future<void> handleEmailRegister(String email, String password) async {
    final result = await registerWithEmail.call(email, password);
    result.fold((failure) => Get.snackbar('Error', failure), (_) => Get.toNamed('/home'));
  }
  bool isUserLoggedIn() {
    return authRepository.isUserLoggedIn();
  }
}