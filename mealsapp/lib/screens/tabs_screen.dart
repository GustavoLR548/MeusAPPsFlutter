import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/drawer/main_drawer.dart';
import '../screens/favorites_screen.dart';

import 'category_screens.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/home';
  final List<Meal> favoriteMeals;

  TabsScreen({this.favoriteMeals});

  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoritesScreen(favoriteMeals: widget.favoriteMeals),
        'title': 'Your Favorites'
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return buildLowerView();
  }

  Widget buildTopView() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title']),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(icon: Icon(Icons.star), text: 'Favorites'),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[CategoriesScreen(), FavoritesScreen()],
          ),
        ));
  }

  Widget buildLowerView() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.yellow,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
            ],
          ),
        ));
  }
}
