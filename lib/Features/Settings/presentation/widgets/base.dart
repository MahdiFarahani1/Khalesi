import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/utils/esay_size.dart';

class ItemSetting extends StatelessWidget {
  final IconData icon;
  final Widget child;
  const ItemSetting({super.key, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: EsaySize.width(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: DropShadow(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        ConstColor.blue,
                      ],
                    )),
                width: EsaySize.width(context),
                child: child,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.5),
                child: CircleAvatar(
                    backgroundColor: ConstColor.blue,
                    child: Icon(
                      icon,
                      color: Colors.white,
                    )),
              ))
        ],
      ),
    );
  }
}
