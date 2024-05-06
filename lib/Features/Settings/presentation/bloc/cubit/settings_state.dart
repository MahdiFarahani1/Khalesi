part of 'settings_cubit.dart';

class SettingsState {
  bool isLightMode;
  bool notif;
  double fontSize;
  String fontFamily;
  double valueFontFamily;

  SettingsState({
    this.fontFamily = FontFamily.arabic,
    this.fontSize = 17,
    this.valueFontFamily = 1,
    this.isLightMode = true,
    this.notif = true,
  });
}
