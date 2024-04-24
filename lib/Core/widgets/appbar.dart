import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';

class CommonAppbar {
  static AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.blue,
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.8, color: Colors.white)),
                      child: Icon(
                        FontAwesomeIcons.barsStaggered,
                        size: 25,
                        color: ConstColor.yellow,
                      ),
                    ),
                  );
                }),
              ),
              Assets.images.logo.image(
                  fit: BoxFit.contain,
                  width: EsaySize.width(context) / 2,
                  height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Transform.rotate(
                  angle: 90 * 3.14159265359 / 180,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.8, color: Colors.white)),
                    child: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 25,
                      color: ConstColor.yellow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
