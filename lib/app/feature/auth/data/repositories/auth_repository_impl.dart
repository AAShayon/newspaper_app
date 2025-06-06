import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, void>> signInWithGoogle() async {
    try {
      await remoteDataSource.signInWithGoogle();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signInWithEmail(String email, String password) async {
    try {
      await remoteDataSource.signInWithEmail(email, password);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> registerWithEmail(String email, String password) async {
    try {
      await remoteDataSource.registerWithEmail(email, password);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  bool isUserLoggedIn() {
    return remoteDataSource.isUserLoggedIn();
  }
  @override
  Future<Either<String, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, UserEntity>> getUserInfo() async {
    try {
      final userInfo = remoteDataSource.getUserInfo();
      return Right(userInfo);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, void>> updatePassword( String newPassword) async {
    try {
      await remoteDataSource.updatePassword( newPassword);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}