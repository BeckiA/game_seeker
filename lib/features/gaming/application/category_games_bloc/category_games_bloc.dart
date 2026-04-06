import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_games.dart';
import 'category_games_event.dart';
import 'category_games_state.dart';

class CategoryGamesBloc extends Bloc<CategoryGamesEvent, CategoryGamesState> {
  final GetGames getGames;

  CategoryGamesBloc({required this.getGames}) : super(CategoryGamesInitial()) {
    on<LoadGamesByCategory>((event, emit) async {
      emit(CategoryGamesLoading());
      final result = await getGames(genreId: event.genreId);
      result.fold(
        (failure) => emit(CategoryGamesError("Could not load filtered games")),
        (games) => emit(CategoryGamesLoaded(games)),
      );
    });
  }
}
