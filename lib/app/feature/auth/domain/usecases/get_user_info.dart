import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserInfo extends Equatable {
  final AuthRepository repository;

  const GetUserInfo(this.repository);

  Future<Either<String, UserEntity>> call() async {
    return await repository.getUserInfo();
  }

  @override
  List<Object?> get props => [];
}