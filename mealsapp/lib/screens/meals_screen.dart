import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/home/meal_selection';
  final List<Meal> availableMeals;

  MealsScreen({@required this.availableMeals});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                  id: displayedMeals[index].id,
                  title: displayedMeals[index].title,
                  imageUrl: displayedMeals[index].imageUrl,
                  duration: displayedMeals[index].duration,
                  complexity: displayedMeals[index].complexity,
                  affordability: displayedMeals[index].affordability);
            },
            itemCount: displayedMeals.length));
  }
}
