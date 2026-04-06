import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/i_gaming_repository.dart';
import '../datasources/gaming_remote_data_source.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/genre.dart';

class GamingRepositoryImpl implements IGamingRepository {
  final IGamingRemoteDataSource remoteDataSource;

  GamingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final remoteGenres = await remoteDataSource.getGenres();
      return Right(remoteGenres); // GenreModel is a Genre, so this works
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Game>>> getGames({String? genreId}) async {
    try {
      final remoteGames = await remoteDataSource.getGames(genreId);
      return Right(remoteGames);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
