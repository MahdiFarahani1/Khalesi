import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/fonts.gen.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/cubit/settings_cubit.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/theme-cubit/theme_cubit.dart';
import 'package:khalesi/Features/Settings/presentation/widgets/base.dart';

class SettingPage extends StatelessWidget {
  static const rn = "/SettingPage";
  const SettingPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CommonAppbar.appBar(context),
          drawer: CommonDrawer.drawer(context),
          body: SingleChildScrollView(
              child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  fontFamily(context, state.valueFontFamily),
                  fontSize(context, state.fontSize),
                  darkMode(context, state.isLightMode),
                  notif(
                    context,
                  ),
                ],
              );
            },
          )),
        ));
  }

  ItemSetting notif(
    BuildContext context,
  ) {
    return ItemSetting(
        icon: Icons.notifications,
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "تفعيل الاشعارات في التطبيق ؟",
                style: TextStyle(fontSize: 16, color: ConstColor.yellow),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<SettingsCubit>(context);

                    AppSettings.openAppSettings(
                        type: AppSettingsType.notification);
                  },
                  icon: Icon(
                    Icons.notifications_active,
                    color: ConstColor.yellow,
                  ))
            ],
          ),
        ));
  }

  ItemSetting darkMode(BuildContext context, bool val) {
    return ItemSetting(
        icon: Icons.color_lens,
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "داكن",
                style: TextStyle(
                  color: ConstColor.yellow,
                  fontSize: 15,
                  decoration:
                      !val ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: ConstColor.yellow,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  activeTrackColor: ConstColor.yellow,
                  value: val,
                  onChanged: (value) {
                    BlocProvider.of<SettingsCubit>(context)
                        .changeisDarkState(value);
                    saveAll.put("islightmode", value);
                    BlocProvider.of<ThemeCubit>(context).changeTheme(value);
                  },
                ),
              ),
              Text(
                "فاتح",
                style: TextStyle(
                    color: ConstColor.yellow,
                    fontSize: 15,
                    decorationColor: ConstColor.yellow,
                    decoration:
                        val ? TextDecoration.underline : TextDecoration.none),
              ),
            ],
          ),
        ));
  }

  ItemSetting fontSize(BuildContext context, double val) {
    return ItemSetting(
      icon: Icons.text_fields,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: ConstColor.yellow,
                trackHeight: 1,
                inactiveTrackColor: const Color.fromRGBO(158, 158, 158, 1),
                thumbColor: ConstColor.yellow,
                inactiveTickMarkColor: Colors.grey,
                activeTickMarkColor: Colors.transparent,
                valueIndicatorColor: ConstColor.yellow,
              ),
              child: Slider(
                label: val.toInt().toString(),
                divisions: 15,
                value: val,
                min: 10,
                max: 25,
                onChanged: (value) {
                  BlocProvider.of<SettingsCubit>(context)
                      .changeFontSizeState(value);
                  saveAll.put("fontsize", value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
              style: TextStyle(fontSize: val, color: ConstColor.yellow),
            ),
          ),
        ],
      ),
    );
  }

  ItemSetting fontFamily(BuildContext context, double val) {
    var realValue = saveAll.get("fontFamily") ?? val;
    return ItemSetting(
        icon: Icons.font_download,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: ConstColor.yellow,
                  trackHeight: 1,
                  inactiveTrackColor: const Color.fromRGBO(158, 158, 158, 1),
                  thumbColor: ConstColor.yellow,
                  inactiveTickMarkColor: Colors.grey,
                  activeTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                  divisions: 2,
                  value: realValue,
                  min: 0,
                  max: 2,
                  onChanged: (value) {
                    BlocProvider.of<SettingsCubit>(context)
                        .changeFontValueState(value);

                    switch (value) {
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
                    saveAll.put("fontFamily", value);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
                style: TextStyle(fontSize: 16, color: ConstColor.yellow),
              ),
            ),
          ],
        ));
  }
}
