import '../../domain/entities/genre.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Genre> genres;
  final int? selectedCategoryId; // Tracks the "Selected" state requirement

  CategoryLoaded({required this.genres, this.selectedCategoryId});
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
