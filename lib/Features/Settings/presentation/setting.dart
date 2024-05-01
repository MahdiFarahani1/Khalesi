import 'package:flutter/material.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';

class SettingPage extends StatelessWidget {
  static const rn = "/SettingPage";
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CommonAppbar.appBar(context),
          drawer: CommonDrawer.drawer(context),
        ));
  }
}
