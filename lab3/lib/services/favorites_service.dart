import '../models/meal_detail.dart';

class FavoritesService {
  static final List<MealDetail> _favorites = [];

  static List<MealDetail> get favorites => _favorites;

  static bool isFavorite(String id) {
    return _favorites.any((m) => m.id == id);
  }

  static void toggleFavorite(MealDetail meal) {
    if (isFavorite(meal.id)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
  }
}
