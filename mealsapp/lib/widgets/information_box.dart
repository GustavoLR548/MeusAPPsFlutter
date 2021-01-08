import 'package:flutter/material.dart';

class InformationBox extends StatelessWidget {
  final String information;
  final IconData icon;
  final double width;

  const InformationBox({this.information, this.icon, this.width});

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(this.icon),
        SizedBox(
          width: this.width,
        ),
        Text(this.information),
      ],
    );
  }
}
