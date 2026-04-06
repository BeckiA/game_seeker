abstract class CategoryEvent {}

class FetchGenres extends CategoryEvent {}

class SelectCategory extends CategoryEvent {
  final int categoryId;
  SelectCategory(this.categoryId);
}
