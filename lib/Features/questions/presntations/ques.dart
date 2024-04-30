import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Features/questions/data/model/ques_model.dart';
import 'package:khalesi/Features/questions/data/source/fetch_ques_data.dart';
import 'package:share_plus/share_plus.dart';

class QuesPage extends StatefulWidget {
  static const String rn = "/questPage";
  const QuesPage({super.key});

  @override
  State<QuesPage> createState() => _QuesPageState();
}

class _QuesPageState extends State<QuesPage> {
  final TextEditingController controller = TextEditingController();
  final PagingController<int, QuestionsModel> pagingController1 =
      PagingController(firstPageKey: 0);
  String highlight = "gogoli";

  @override
  void initState() {
    DataQuestSource.fetchData(
        pagingController1: pagingController1, context: context);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CommonAppbar.appBar(context),
          drawer: CommonDrawer.drawer(context),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "الغاء :",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: EsaySize.width(context) * 0.8,
                      height: 40,
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            if (controller.text != "") {
                              highlight = controller.text;
                            }
                          });
                        },
                        controller: controller,
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: ConstColor.blue,
                        cursorHeight: 15,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstColor.blue),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: ConstColor.blue),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (controller.text != "") {
                                  highlight = controller.text;
                                }
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PagedListView<int, QuestionsModel>(
                  pagingController: pagingController1,
                  builderDelegate: PagedChildBuilderDelegate<QuestionsModel>(
                    firstPageProgressIndicatorBuilder: (context) {
                      return CostumLoading.fadingCircle(context);
                    },
                    itemBuilder: (context, item, index) {
                      return Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "السوال :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.red.shade800),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              child: TextHighlight(
                                textAlign: TextAlign.justify,
                                text: item.content!,
                                words: {
                                  highlight: HighlightedWord(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: ConstColor.yellow))
                                },
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("الجواب :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.green.shade900)),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              child: TextHighlight(
                                textAlign: TextAlign.justify,
                                text: item.answer!,
                                words: {
                                  highlight: HighlightedWord(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: ConstColor.yellow))
                                },
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )),
                          Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Share.share(
                                      "السوال \n ${item.content}\n الجواب\n${item.answer}");
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 0.2,
                                              spreadRadius: 0.2,
                                              color: ConstColor.blue,
                                              offset: const Offset(
                                                1,
                                                1,
                                              ))
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: ConstColor.yellow),
                                    child: const Icon(
                                      Icons.ios_share_outlined,
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.2,
                                          spreadRadius: 0.2,
                                          color: ConstColor.blue,
                                          offset: const Offset(
                                            -1,
                                            -1,
                                          ))
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstColor.yellow),
                                child: Center(
                                    child: Text(
                                  item.id.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                              )
                            ],
                          )
                        ]),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
