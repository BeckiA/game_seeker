import '../../domain/entities/game.dart';

abstract class AllGamesState {}

class AllGamesInitial extends AllGamesState {}

class AllGamesLoading extends AllGamesState {}

class AllGamesLoaded extends AllGamesState {
  final List<Game> games;
  AllGamesLoaded(this.games);
}

class AllGamesError extends AllGamesState {
  final String message;
  AllGamesError(this.message);
}
