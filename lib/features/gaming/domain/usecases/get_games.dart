import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/game.dart';
import '../repositories/i_gaming_repository.dart';

class GetGames {
  final IGamingRepository repository;

  GetGames(this.repository);

  /// If [genreId] is provided, it fetches games for that specific category.
  /// If [genreId] is null, it fetches the general list of games.
  Future<Either<Failure, List<Game>>> call({String? genreId}) async {
    return await repository.getGames(genreId: genreId);
  }
}
