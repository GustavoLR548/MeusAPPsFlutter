import 'package:flutter/material.dart';
import 'package:mealsapp/screens/filters_screen.dart';
import 'package:mealsapp/screens/tabs_screen.dart';
import './main_drawer_option_box.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            'Cooking up!',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        OptionBox(
          text: 'Meals',
          icon: Icons.restaurant,
          tapHandler: () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          },
        ),
        OptionBox(
            text: 'Filters',
            icon: Icons.settings,
            tapHandler: () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            }),
      ]),
    );
  }
}
