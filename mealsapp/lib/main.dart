import 'package:flutter/material.dart';
import 'package:mealsapp/screens/category_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.purple[50],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Colors.black38),
            body2: TextStyle(color: Colors.black38)),
      ),
      home: CategoriesScreen(),
    );
  }
}
