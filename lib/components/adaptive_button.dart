import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptiveButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label, style: TextStyle(color: Colors.white)),
            onPressed: onPressed,
            color: Theme.of(context).accentColor,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          )
        : RaisedButton(
            child: Text(label, style: TextStyle(color: Colors.white)),
            color: Theme.of(context).accentColor,
            onPressed: onPressed,
          );
  }
}
