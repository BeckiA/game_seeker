import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/genre.dart';
import '../repositories/i_gaming_repository.dart';

class GetGenres {
  final IGamingRepository repository;

  GetGenres(this.repository);

  Future<Either<Failure, List<Genre>>> call() async {
    return await repository.getGenres();
  }
}
