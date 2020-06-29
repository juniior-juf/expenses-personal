import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) onSubmitted;

  const AdaptiveTextField({
    Key key,
    this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              placeholder: label,
              controller: controller,
              onSubmitted:  onSubmitted,
              keyboardType: inputType,
              textCapitalization: TextCapitalization.sentences,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: inputType,
            decoration: InputDecoration(
              labelText: label,
            ),
            textCapitalization: TextCapitalization.sentences,
          );
  }
}
