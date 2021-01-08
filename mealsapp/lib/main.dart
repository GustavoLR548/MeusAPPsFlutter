import 'package:flutter/material.dart';
import 'package:mealsapp/screens/category_screens.dart';
import './dummy.dart';
import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/meals_screen.dart';

import 'models/meal.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0)
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    else
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.purple[50],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black38),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: TabsScreen.routeName,
      routes: {
        TabsScreen.routeName: (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        MealsScreen.routeName: (ctx) => MealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetails.routeName: (ctx) => MealDetails(
              toggleFavorite: _toggleFavorites,
              isFavorite: _isMealFavorite,
            ),
        FilterScreen.routeName: (ctx) => FilterScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabsScreen());
      },
    );
  }
}
