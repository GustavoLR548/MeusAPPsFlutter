import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen({this.favoriteMeals});
  Widget build(BuildContext context) {
    if (favoriteMeals == null || favoriteMeals.isEmpty) {
      return Center(
        child: Text('No favorites'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: favoriteMeals[index].id,
                title: favoriteMeals[index].title,
                imageUrl: favoriteMeals[index].imageUrl,
                duration: favoriteMeals[index].duration,
                complexity: favoriteMeals[index].complexity,
                affordability: favoriteMeals[index].affordability);
          },
          itemCount: favoriteMeals.length);
    }
  }
}
