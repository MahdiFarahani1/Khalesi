import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khalesi/Core/const/const_Color.dart';

class CostumLoading {
  static Widget loadCircle(BuildContext context) {
    return SpinKitRipple(
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ConstColor.yellow,
          ),
        );
      },
    );
  }

  static Widget loadLine(BuildContext context) {
    return SpinKitThreeInOut(
      size: 35,
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ConstColor.yellow,
          ),
        );
      },
    );
  }

  static Widget fadingCircle(BuildContext context) {
    return SpinKitFadingCircle(
      size: 35,
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ConstColor.yellow,
          ),
        );
      },
    );
  }
}
