abstract class CategoryGamesEvent {}

class LoadGamesByCategory extends CategoryGamesEvent {
  final String genreId;
  LoadGamesByCategory(this.genreId);
}
