import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/const/const_link.dart';
import 'package:khalesi/Core/extra/format_date.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/fetchContentApi/cubit/content_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/fetchContentApi/model/content_model.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';
import 'package:khalesi/Features/Save/data/dataBase/model_database.dart';
import 'package:khalesi/Features/Save/presentation/bloc/save_news_cubit.dart';
import 'package:khalesi/Features/Settings/presentation/bloc/cubit/settings_cubit.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ClickPage extends StatefulWidget {
  final int id;
  final bool isSaveMode;
  final String categoryTitle;
  const ClickPage(
      {super.key,
      this.isSaveMode = false,
      required this.id,
      required this.categoryTitle});

  @override
  State<ClickPage> createState() => _ClickPageState();
}

class _ClickPageState extends State<ClickPage> {
  bool iconSelect = false;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    iconSelect = saveAll.get("iconSelect${widget.id}") ?? false;
    if (widget.isSaveMode) {
      BlocProvider.of<ContentCubit>(context).fetchDataSave(
          id: widget.id, context: context, categoryTitle: widget.categoryTitle);
    } else {
      BlocProvider.of<ContentCubit>(context)
          .fetchData(id: widget.id, context: context);
    }
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbar.appBar(context),
        drawer: CommonDrawer.drawer(context),
        body: BlocBuilder<ContentCubit, ContentState>(
          builder: (context, state) {
            if (state.status is ClickLoading) {
              return Center(
                child: CostumLoading.fadingCircle(context),
              );
            }
            if (state.status is ClickError) {
              return const Text("error");
            }
            if (state.status is ClickComplete) {
              var data = state.data as ContentModel;
              String content = data.post![0].content!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(60)),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ConstLink.imgBasehigh}${data.post![0].img}",
                        fit: BoxFit.cover,
                        width: EsaySize.width(context),
                        height: EsaySize.height(context) / 3.5,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                        placeholder: (context, url) {
                          return Center(
                            child: CostumLoading.fadingCircle(context),
                          );
                        },
                      ),
                    ),
                    titleUi(
                      categoryTitle: data.post![0].categoryTitle!,
                      id: data.post![0].id!,
                      title: data.post![0].title!,
                      time: data.post![0].dateTime!,
                      img: "${ConstLink.imgBasehigh}${data.post![0].img}",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          return HtmlWidget(
                            '''
                                                <div style="text-align: justify;">
                                                $content
                                                                    </div>
                                                                    ''',
                            textStyle: TextStyle(fontSize: state.fontSize),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget titleUi({
    required int time,
    required String title,
    required String img,
    required int id,
    required String categoryTitle,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0, top: 12),
          width: EsaySize.width(context),
          height: 45,
          color: ConstColor.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  "حجم الخط :",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: EsaySize.width(context) * 0.38),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SettingsCubit>(context).plusFont();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: ConstColor.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    EsaySize.gap(8),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SettingsCubit>(context).nagitivFont();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: ConstColor.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          FontAwesomeIcons.minus,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        String tag = "";

                        switch (BlocProvider.of<HomeMainCubit>(context)
                            .state
                            .status) {
                          case News():
                            tag = "n";
                            break;
                          case Speech():
                            tag = "p";
                            break;
                          case Sermon():
                            tag = "s";
                            break;
                          case Article():
                            tag = "a";
                            break;
                          default:
                        }
                        Share.share("https://alkhalissi.org/$tag${widget.id}");
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: ConstColor.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.ios_share_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    EsaySize.gap(12),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return StatefulBuilder(builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              var model = ModelDataBase(
                                categoryTitle: categoryTitle,
                                path: img,
                                time: FormatData.result(time),
                                title: title,
                                id: id,
                              );
                              if (!iconSelect) {
                                saveAll.put("iconSelect${widget.id}", true);

                                saveModel.add(model);
                              } else {
                                saveAll.delete("iconSelect${widget.id}");

                                for (var value in saveModel.values) {
                                  if (value.id == model.id) {
                                    var keyToRemove = saveModel.keys.firstWhere(
                                        (key) => saveModel.get(key) == value,
                                        orElse: () => null);
                                    if (keyToRemove != null) {
                                      saveModel.delete(keyToRemove);
                                    }
                                  }
                                }
                              }

                              iconSelect = !iconSelect;
                              setState(
                                () {},
                              );
                              BlocProvider.of<SaveNewsCubit>(context)
                                  .loadSave(context);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: ConstColor.yellow,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                !iconSelect
                                    ? Icons.bookmark_add_outlined
                                    : Icons.bookmark,
                                color: Colors.white,
                              ),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 3,
                      title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    EsaySize.gap(8),
                    Container(
                      width: 140,
                      height: 1,
                      color: const Color.fromRGBO(142, 201, 51, 1),
                    ),
                    EsaySize.gap(8),
                    Row(
                      children: [
                        const Text(
                          "الاخبار",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        EsaySize.gap(6),
                        const Text(
                          "__",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        EsaySize.gap(6),
                        Text(
                          FormatData.result(time),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
