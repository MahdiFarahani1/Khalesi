import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khalesi/Config/app-routes.dart';
import 'package:khalesi/Core/gen/fonts.gen.dart';
import 'package:khalesi/Features/Audio/presentation/bloc/audio/audio_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/fetchContentApi/cubit/content_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/indicator/indicator_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/navbar/nav_bar_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/slider/slider_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/home_main.dart';
import 'package:khalesi/Features/Save/data/dataBase/model_database.dart';
import 'package:khalesi/Features/Save/presentation/bloc/save_news_cubit.dart';
import 'package:khalesi/Features/Search/presententaion/Search-main/search_cubit.dart';

late Box saveAll;
late Box saveModel;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  saveAll = await Hive.openBox("saveAll");

  Hive.registerAdapter(ModelDataBaseAdapter());
  saveModel = await Hive.openBox<ModelDataBase>("saveModel");

  runApp(const MyApp());
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
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: RoutesApp.routes,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: FontFamily.arabic),
        home: MyHomePage(),
      ),
    );
  }
}
