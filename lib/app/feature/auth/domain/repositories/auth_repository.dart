import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, void>> signInWithGoogle();
  Future<Either<String, void>> signInWithEmail(String email, String password);
  Future<Either<String, void>> registerWithEmail(String email, String password);
  bool isUserLoggedIn();
  Future<Either<String, void>> signOut();
  Future<Either<String, UserEntity>> getUserInfo();
  Future<Either<String, void>> updatePassword(String password);
}