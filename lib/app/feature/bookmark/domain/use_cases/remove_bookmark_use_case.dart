import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/favorite_repository.dart';

class RemoveBookmarkUseCase extends Equatable {
  final BookmarkRepository repository;

  const RemoveBookmarkUseCase(this.repository);

  Future<Either<String, void>> call(String userId, String bookmarkId) async {
    try {
      await repository.removeBookmark(userId, bookmarkId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  List<Object?> get props => [];
}