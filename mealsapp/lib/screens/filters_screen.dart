import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/drawer/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/build/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen({this.currentFilters, this.saveFilters});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function updateFunction) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: updateFunction,
    );
  }

  void _updateCurrentFilters() {
    final selectedFilters = {
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegan': _vegan,
      'vegetarian': _vegetarian
    };
    widget.saveFilters(selectedFilters);
  }

  Widget build(BuildContext context) {
    print('cheguei!');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              )),
          Expanded(
              child: ListView(children: <Widget>[
            _buildSwitchListTile(
                'Gluten Free', 'Only include gluten-free meals', _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
              _updateCurrentFilters();
            }),
            _buildSwitchListTile(
                'Lactose Free', 'Only include lactose-free meals', _lactoseFree,
                (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
              _updateCurrentFilters();
            }),
            _buildSwitchListTile(
                'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
              _updateCurrentFilters();
            }),
            _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
              _updateCurrentFilters();
            }),
          ])),
        ],
      ),
    );
  }
}
