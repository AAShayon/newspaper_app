import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmail extends Equatable {
  final AuthRepository repository;

  const RegisterWithEmail(this.repository);

  Future<Either<String, void>> call(String email, String password) async {
    return await repository.registerWithEmail(email, password);
  }

  @override
  List<Object?> get props => [];
}