import '../../domain/entities/game.dart';

abstract class CategoryGamesState {}

class CategoryGamesInitial extends CategoryGamesState {}

class CategoryGamesLoading extends CategoryGamesState {}

class CategoryGamesLoaded extends CategoryGamesState {
  final List<Game> games;
  CategoryGamesLoaded(this.games);
}

class CategoryGamesError extends CategoryGamesState {
  final String message;
  CategoryGamesError(this.message);
}
