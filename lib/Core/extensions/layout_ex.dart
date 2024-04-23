import 'package:flutter/material.dart';

extension Layout on double {
  EdgeInsets padAllCostume() {
    return EdgeInsets.all(this);
  }

  EdgeInsets padAllConst() {
    return const EdgeInsets.all(8.0);
  }

  BoxDecoration decor(Color color) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(this));
  }
}
