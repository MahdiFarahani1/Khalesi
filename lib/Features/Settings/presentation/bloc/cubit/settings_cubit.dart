import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Core/gen/fonts.gen.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  initStateForSetting(BuildContext context) async {
    var fontsize = await saveAll.get("fontsize") ?? 17.0;
    var islightmode = await saveAll.get("islightmode") ?? true;
    var notif = await saveAll.get("notif") ?? true;

    var fontFamily = await saveAll.get("fontFamily") ?? 1;

    switch (fontFamily) {
      case 0:
        BlocProvider.of<SettingsCubit>(context)
            .changeFontFamilyState(FontFamily.salamat);
        break;
      case 1:
        BlocProvider.of<SettingsCubit>(context)
            .changeFontFamilyState(FontFamily.arabic);
        break;
      case 2:
        BlocProvider.of<SettingsCubit>(context)
            .changeFontFamilyState(FontFamily.trajan);
        break;
      default:
    }

    emit(SettingsState(
        notif: notif,
        fontFamily: state.fontFamily,
        fontSize: fontsize,
        isLightMode: islightmode,
        valueFontFamily: state.valueFontFamily));
  }

  changeNotifState(bool value) {
    emit(SettingsState(
        notif: value,
        fontFamily: state.fontFamily,
        fontSize: state.fontSize,
        isLightMode: state.isLightMode,
        valueFontFamily: state.valueFontFamily));
  }

  changeisDarkState(bool value) {
    emit(SettingsState(
        isLightMode: value,
        notif: state.notif,
        fontFamily: state.fontFamily,
        fontSize: state.fontSize,
        valueFontFamily: state.valueFontFamily));
  }

  changeFontSizeState(double value) {
    emit(SettingsState(
        fontSize: value,
        fontFamily: state.fontFamily,
        notif: state.notif,
        isLightMode: state.isLightMode,
        valueFontFamily: state.valueFontFamily));
  }

  plusFont() {
    if (state.fontSize >= 10 && state.fontSize < 25) {
      emit(SettingsState(
          fontSize: state.fontSize + 1,
          notif: state.notif,
          isLightMode: state.isLightMode,
          fontFamily: state.fontFamily,
          valueFontFamily: state.valueFontFamily));
    }
  }

  nagitivFont() {
    if (state.fontSize > 10) {
      emit(SettingsState(
          fontSize: state.fontSize - 1,
          notif: state.notif,
          isLightMode: state.isLightMode,
          fontFamily: state.fontFamily,
          valueFontFamily: state.valueFontFamily));
    }
  }

  changeFontFamilyState(String val) {
    emit(SettingsState(
        fontSize: state.fontSize,
        fontFamily: val,
        notif: state.notif,
        isLightMode: state.isLightMode,
        valueFontFamily: state.valueFontFamily));
  }

  changeFontValueState(double val) {
    emit(SettingsState(
        fontSize: state.fontSize,
        fontFamily: state.fontFamily,
        notif: state.notif,
        isLightMode: state.isLightMode,
        valueFontFamily: val));
  }
}
