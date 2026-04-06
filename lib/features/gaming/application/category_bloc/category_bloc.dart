import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_genres.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetGenres getGenres;

  CategoryBloc({required this.getGenres}) : super(CategoryInitial()) {
    on<FetchGenres>((event, emit) async {
      emit(CategoryLoading());
      final result = await getGenres();

      result.fold(
        (failure) => emit(CategoryError("Failed to fetch genres")),
        (genres) => emit(CategoryLoaded(genres: genres)),
      );
    });

    on<SelectCategory>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        // Re-emitting the loaded state with a new selected ID
        emit(
          CategoryLoaded(
            genres: currentState.genres,
            selectedCategoryId: event.categoryId,
          ),
        );
      }
    });
  }
}
