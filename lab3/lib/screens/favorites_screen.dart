import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService.favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemCount: favorites.length,
        itemBuilder: (ctx, i) {
          final meal = favorites[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                MealDetailScreen.routeName,
                arguments: meal,
              );
            },
            child: Image.network(meal.thumbnail),
          );
        },
      ),
    );
  }
}
