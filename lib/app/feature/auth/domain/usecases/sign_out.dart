import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

class SignOutUser extends Equatable {
  final AuthRepository authRepository;

  const SignOutUser(this.authRepository);

  Future<Either<String, void>> call() async {
    return await authRepository.signOut();
  }

  @override
  List<Object?> get props => [];
}