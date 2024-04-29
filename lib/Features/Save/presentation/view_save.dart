import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/fonts.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Core/widgets/navbar.dart';
import 'package:khalesi/Features/Home/presentaties/widgets/news_item.dart';
import 'package:khalesi/Features/Save/presentation/bloc/save_news_cubit.dart';

class SavePage extends StatefulWidget {
  static const String rn = "/savePage";

  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  void initState() {
    BlocProvider.of<SaveNewsCubit>(context).loadSave(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: CommonDrawer.drawer(context),
          bottomNavigationBar: CommonNavbar.botNav(),
          appBar: CommonAppbar.appBar(context),
          body: BlocBuilder<SaveNewsCubit, SaveNewsState>(
            builder: (context, state) {
              if (state.savedItem.isEmpty) {
                return Container(
                  width: EsaySize.width(context),
                  height: 100,
                  decoration: BoxDecoration(
                      color: ConstColor.blue,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 20.0, fontFamily: FontFamily.arabic),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        pause: const Duration(seconds: 1),
                        animatedTexts: [
                          TypewriterAnimatedText('لم يتم العثور على نتيجة'),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(
                      isSaveMode: true,
                      catgoryTitle: state.savedItem[index].categoryTitle,
                      path: state.savedItem[index].path,
                      title: state.savedItem[index].title,
                      time: state.savedItem[index].time,
                      id: state.savedItem[index].id);
                },
                itemCount: state.savedItem.length,
              );
            },
          )),
    );
  }
}
