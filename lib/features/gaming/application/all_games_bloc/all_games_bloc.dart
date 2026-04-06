import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_games.dart';
import 'all_games_event.dart';
import 'all_games_state.dart';

class AllGamesBloc extends Bloc<AllGamesEvent, AllGamesState> {
  final GetGames getGames;

  AllGamesBloc({required this.getGames}) : super(AllGamesInitial()) {
    on<LoadAllGames>((event, emit) async {
      emit(AllGamesLoading());
      final result = await getGames();
      result.fold(
        (failure) => emit(AllGamesError("Could not load games")),
        (games) => emit(AllGamesLoaded(games)),
      );
    });
  }
}
