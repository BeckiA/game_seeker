import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/game.dart';
import '../entities/genre.dart';

abstract class IGamingRepository {
  Future<Either<Failure, List<Genre>>> getGenres();

  // This handles both "All Games" and "Games by Category"
  // If genreId is null, it fetches all games.
  Future<Either<Failure, List<Game>>> getGames({String? genreId});
}
