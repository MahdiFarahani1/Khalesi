import 'package:flutter/material.dart';

extension StringWidget on String {
  Text readyText({TextStyle? style}) {
    return Text(
      this,
      style: style,
    );
  }
}
