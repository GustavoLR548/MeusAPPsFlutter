import 'package:flutter/material.dart';

class OptionBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function tapHandler;

  const OptionBox({@required this.text, this.icon, @required this.tapHandler});

  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
