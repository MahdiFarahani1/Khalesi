import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String aliveCon = "";
  final TextEditingController textEditingController = TextEditingController();
  final controllerWeb = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  double fontSize = 16.0;

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

  void _changeFontSize(double change) {
    fontSize += change;

    setState(() {});
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
              var date = FormatData.result(data.post![0].dateTime!);

              String content = data.post![0].content!;

              return Column(
                children: [
                  titleUi(
                    categoryTitle: data.post![0].categoryTitle!,
                    id: data.post![0].id!,
                    title: data.post![0].title!,
                    time: data.post![0].dateTime!,
                    img: "${ConstLink.imgBasehigh}${data.post![0].img}",
                  ),
                  Expanded(
                    child: WebViewWidget(
                      controller: controllerWeb
                        ..loadHtmlString(
                          '''
                                <html>
                                  <head>
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

                                    <style>
                                      body { text-align: justify;
                                      padding: 10px !important;
                                         }
         img {
      width: 100%;
      height: 200px;

    }
 
       
                                      iframe{
  width: 100%;
            height: 200px;

                                      }
                                      span{
                                                                             
 font-size: ${fontSize}px !important;
                                      }
                                      #headerImage{
    width: 100%;
  height: auto !important;
        border-radius: 8px;


                                      }
                                      #dateNews{
                                        
                          color: grey;
                                      }
                                    </style>
                                  </head>
                                  <body dir ="rtl">
                                  <img id="headerImage" src="${ConstLink.imgBasehigh}${data.post![0].img}" alt=""><br><br>
                                  <span id="dateNews">$date  __  ${data.post![0].categoryTitle!} </span>
                                    $content

                                    <script>
                                    
                                    var images = document.getElementsByTagName('img');
for (var i = 0; i < images.length; ++i) {
  var img = images[i];
  var a = document.createElement('a');
  a.href = img.src;
  img.parentNode.replaceChild(a, img);
  a.appendChild(img);
}
                                    </script>
                                  </body>
                                </html>
                              ''',
                        ),
                    ),
                  ),
                ],
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
                        _changeFontSize(2.0);
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
                        _changeFontSize(-2.0);
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
      ],
    );
  }
}
