import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail extends Equatable {
  final AuthRepository repository;

  const SignInWithEmail(this.repository);

  Future<Either<String, void>> call(String email, String password) async {
    return await repository.signInWithEmail(email, password);
  }

  @override
  List<Object?> get props => [];
}