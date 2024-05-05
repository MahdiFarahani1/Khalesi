import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Config/firebase.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Features/Home/presentaties/home_main.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/cubit/settings_cubit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      BlocProvider.of<SettingsCubit>(context).initStateForSetting(context);
      Navigator.pushReplacementNamed(context, MyHomePage.rn);
      _fire();
    });
    super.initState();
  }

  _fire() async {
    await setUpFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: EsaySize.width(context),
        height: EsaySize.height(context),
        child: Assets.images.splash.image(fit: BoxFit.cover),
      ),
    );
  }
}
