import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Features/Home/presentaties/widgets/drawer_item.dart';

class CommonDrawer {
  static Widget drawer(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AnimateGradient(
          duration: const Duration(seconds: 6),
          primaryColors: [
            const Color.fromARGB(255, 105, 205, 252),
            Colors.blueAccent,
            ConstColor.blue,
          ],
          secondaryColors: [
            ConstColor.blue,
            Colors.blueAccent,
            const Color.fromARGB(255, 105, 205, 252),
          ],
          child: SizedBox(
              width: EsaySize.width(context) / 1.5,
              child: DrawerItem.allItems(context)),
        ),
      ),
    );
  }
}
