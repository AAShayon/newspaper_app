import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, void>> signInWithGoogle();
  Future<Either<String, void>> signInWithEmail(String email, String password);
  Future<Either<String, void>> registerWithEmail(String email, String password);
  bool isUserLoggedIn();
}