import 'package:flutter/material.dart';

import '../dummy.dart';

class MealDetails extends StatelessWidget {
  static const routeName = '/home/meal_details';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetails({@required this.toggleFavorite, @required this.isFavorite});

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: Theme.of(context).textTheme.headline1));
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        width: 300,
        child: child);
  }

  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final listOfIngredients = ListView.builder(
      itemCount: selectedMeal.ingredients.length,
      itemBuilder: (ctx, index) => Card(
          color: Theme.of(context).accentColor,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(selectedMeal.ingredients[index]))),
    );

    final listOfSteps = ListView.builder(
        itemCount: selectedMeal.steps.length,
        itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                ListTile(
                    leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                    title: Text(selectedMeal.steps[index])),
                Divider()
              ],
            ));

    return Scaffold(
        appBar: AppBar(title: Text('${selectedMeal.title}')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: 300,
                  width: double.infinity,
                  child:
                      Image.network(selectedMeal.imageUrl, fit: BoxFit.cover)),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(listOfIngredients),
              buildSectionTitle(context, 'Steps'),
              buildContainer(listOfSteps),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFavorite(mealId),
        ));
  }
}
