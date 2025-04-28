import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

class UpdatePassword extends Equatable {
  final AuthRepository repository;

  const UpdatePassword(this.repository);

  Future<Either<String, void>> call(String password) async {
    return await repository.updatePassword(password);
  }

  @override
  List<Object?> get props => [];
}