import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle extends Equatable {
  final AuthRepository repository;

  const SignInWithGoogle(this.repository);

  Future<Either<String, void>> call() async {
    return await repository.signInWithGoogle();
  }

  @override
  List<Object?> get props => [];
}