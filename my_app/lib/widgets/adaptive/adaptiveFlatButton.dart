import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  Function _onPressed;
  String _text;

  AdaptiveFlatButton({Function onPressed, String text}) {
    this._onPressed = onPressed;
    this._text = text;
  }

  @override
  Widget build(BuildContext context) {
    final ehIOS = Platform.isIOS;

    final deviceSettings = MediaQuery.of(context);

    final PreferredSizeWidget resp = ehIOS
        ? CupertinoButton(
            color: Colors.blue,
            child: Text(_text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20 * deviceSettings.textScaleFactor)),
            onPressed: _onPressed)
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(_text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20 * deviceSettings.textScaleFactor)),
            onPressed: _onPressed,
          );

    return resp;
  }
}
