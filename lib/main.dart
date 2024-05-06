import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Config/app-routes.dart';
import 'package:khalesi/Config/firebase.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Config/theme/theme.dart';
import 'package:khalesi/Features/Audio/presentation/bloc/audio/audio_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/fetchContentApi/cubit/content_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/indicator/indicator_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/navbar/nav_bar_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/slider/slider_cubit.dart';
import 'package:khalesi/Features/Save/presentation/bloc/save_news_cubit.dart';
import 'package:khalesi/Features/Search/presententaion/Search-main/search_cubit.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/cubit/settings_cubit.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/theme-cubit/theme_cubit.dart';
import 'package:khalesi/Features/splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await setUp();
  await setUpFirebase();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavBarCubit(),
        ),
        BlocProvider(
          create: (context) => IndicatorCubit(),
        ),
        BlocProvider(
          create: (context) => SliderCubit(),
        ),
        BlocProvider(
          create: (context) => HomeMainCubit(),
        ),
        BlocProvider(
          create: (context) => ContentCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => SaveNewsCubit(),
        ),
        BlocProvider(
          create: (context) => AudioCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, stateTheme) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: "/",
                routes: RoutesApp.routes,
                theme: ThemeApp.darkThemeData(
                    shadowcolor: stateTheme.shadowColor,
                    fontFamily: state.fontFamily,
                    background: stateTheme.background,
                    item: stateTheme.item,
                    reverceColor: stateTheme.reverceColor),
                darkTheme: ThemeApp.darkThemeData(
                    shadowcolor: stateTheme.shadowColor,
                    fontFamily: state.fontFamily,
                    background: stateTheme.background,
                    item: stateTheme.item,
                    reverceColor: stateTheme.reverceColor),
                themeMode: ThemeMode.system,
                home: const Splash(),
              );
            },
          );
        },
      ),
    );
  }
}
