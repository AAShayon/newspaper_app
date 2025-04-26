import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/news_repository.dart';
import '../entities/news_entity.dart';

class GetTopHeadlines extends Equatable {
  final NewsRepository repository;

  const GetTopHeadlines(this.repository);

  Future<Either<String, NewsEntity>> call() async {
    return await repository.getTopHeadlines();
  }

  @override
  List<Object?> get props => [];
}