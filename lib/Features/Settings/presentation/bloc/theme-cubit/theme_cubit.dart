import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khalesi/Config/setup.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            background: Colors.white,
            item: Colors.grey.shade200,
            reverceColor: Colors.black,
            shadowColor: Colors.grey.shade600));

  initState(BuildContext context) {
    var cheker = saveAll.get("islightmode") ??
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    emit(ThemeState(
        background: cheker ? Colors.white : Colors.black,
        item: cheker ? Colors.grey.shade200 : Colors.grey.shade900,
        reverceColor: cheker ? Colors.black : Colors.white,
        shadowColor: cheker ? Colors.grey.shade600 : Colors.amberAccent));
  }

  changeTheme(bool val) {
    if (val) {
      emit(ThemeState(
          background: Colors.white,
          item: Colors.grey.shade200,
          reverceColor: Colors.black,
          shadowColor: Colors.grey.shade600));
    } else {
      emit(ThemeState(
          background: Colors.black,
          item: Colors.grey.shade900,
          reverceColor: Colors.white,
          shadowColor: Colors.amberAccent));
    }
  }
}
