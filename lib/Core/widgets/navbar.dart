import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/navbar/nav_bar_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/home_main.dart';

class CommonNavbar {
  static Widget botNav() {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return FlashyTabBar(
          backgroundColor: ConstColor.blue,
          selectedIndex: state.index,
          showElevation: true,
          onItemSelected: (value) {
            BlocProvider.of<NavBarCubit>(context).changeState(value);
            BlocProvider.of<HomeMainCubit>(context).changeState(value);
            Navigator.pushNamed(context, MyHomePage.rn);
          },
          items: [
            FlashyTabBarItem(
              activeColor: ConstColor.yellow,
              inactiveColor: Colors.white,
              icon: const Icon(
                FontAwesomeIcons.newspaper,
                size: 25,
              ),
              title: const Text('الاخبار'),
            ),
            FlashyTabBarItem(
              activeColor: ConstColor.yellow,
              inactiveColor: Colors.white,
              icon: const Icon(
                Icons.feed_outlined,
                size: 27,
              ),
              title: const Text('البيانات'),
            ),
            FlashyTabBarItem(
              activeColor: ConstColor.yellow,
              inactiveColor: Colors.white,
              icon: const Icon(
                Icons.edit_note_outlined,
                size: 35,
              ),
              title: const Text('خطب الجمعة'),
            ),
            FlashyTabBarItem(
              activeColor: ConstColor.yellow,
              inactiveColor: Colors.white,
              icon: const Icon(
                Icons.edit_calendar_rounded,
                size: 26,
              ),
              title: const Text('المقالات'),
            ),
          ],
        );
      },
    );
  }
}
