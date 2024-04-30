import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/const/const_link.dart';
import 'package:khalesi/Core/extensions/variyable_ex.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Core/widgets/navbar.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';
import 'package:khalesi/Features/Home/presentaties/widgets/news_item.dart';
import 'package:khalesi/Features/Search/presententaion/Search-main/search_cubit.dart';

class SearchPage extends StatefulWidget {
  static const String rn = "/searchpages";
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    pagingController1.addPageRequestListener((page) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        BlocProvider.of<SearchCubit>(context).fetchData(
            start: page,
            pagingController1: pagingController1,
            context: context,
            sw: controller.text,
            title: titleBool ? 1 : 0,
            content: contentBool ? 1 : 0,
            mode: nameDrop.searchCategory());
      });
    });

    super.initState();
  }

  final PagingController<int, NewsGet> pagingController1 =
      PagingController(firstPageKey: 0);
  var titleBool = true;
  var contentBool = true;

  final controller = TextEditingController();
  String nameDrop = "الاخبار";
  final List<String> items = [
    'الاخبار',
    'البيانات',
    'خطب الجمعة',
    'المقالات',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ConstColor.blue,
          actions: [
            SizedBox(
              width: EsaySize.width(context),
              height: 50,
              child: TextField(
                onSubmitted: (value) {
                  BlocProvider.of<SearchCubit>(context).fetchData(
                      start: 0,
                      pagingController1: pagingController1,
                      context: context,
                      sw: controller.text,
                      title: titleBool ? 1 : 0,
                      content: contentBool ? 1 : 0,
                      mode: nameDrop.searchCategory());
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
                      BlocProvider.of<SearchCubit>(context).fetchData(
                          start: 0,
                          pagingController1: pagingController1,
                          context: context,
                          sw: controller.text,
                          title: titleBool ? 1 : 0,
                          content: contentBool ? 1 : 0,
                          mode: nameDrop.searchCategory());
                    },
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CommonNavbar.botNav(),
        drawer: CommonDrawer.drawer(context),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Row(
                  children: [
                    EsaySize.gap(6),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstColor.blue,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: chekBox("النص", contentBool, (p0) {
                              setState(() {
                                contentBool = !contentBool;
                              });
                            }),
                          ),
                          EsaySize.gap(8),
                          chekBox("العنوان", titleBool, (p0) {
                            setState(() {
                              titleBool = !titleBool;
                            });
                          }),
                        ],
                      ),
                    ),
                    EsaySize.gap(4),
                    Expanded(
                        child: Container(
                      height: 3,
                      color: ConstColor.yellow,
                    )),
                    EsaySize.gap(4),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                        items: items
                            .map(
                              (String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        value: nameDrop,
                        onChanged: (value) {
                          setState(() {
                            nameDrop = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: ConstColor.blue,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: ConstColor.blue,
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    EsaySize.gap(6),
                  ],
                ),
              ),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.status is CompleteSearch) {
                    return Expanded(
                        child: PagedListView<int, NewsGet>(
                      builderDelegate: PagedChildBuilderDelegate<NewsGet>(
                        newPageProgressIndicatorBuilder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CostumLoading.fadingCircle(context),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return const SizedBox.shrink();
                        },
                        itemBuilder: (context, item, index) {
                          return NewsItem(
                              catgoryTitle: item.categoryTitle!,
                              path: "${ConstLink.imgBaselow}${item.img!}",
                              title: item.title!,
                              time: item.dateTime!,
                              id: item.id!);
                        },
                      ),
                      pagingController: pagingController1,
                    ));
                  }
                  if (state.status is LoadingSearch) {
                    return Expanded(
                      child: CostumLoading.fadingCircle(context),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Row chekBox(String txt, bool modeBool, void Function(bool?)? changed) {
    return Row(
      children: [
        Text(
          txt,
          style: const TextStyle(color: Colors.white),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 20,
          height: 20,
          child: Transform.scale(
            scale: 0.85,
            child: Checkbox(
              side: BorderSide.none,
              fillColor: MaterialStatePropertyAll(ConstColor.yellow),
              shape: const BeveledRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              value: modeBool,
              onChanged: changed,
            ),
          ),
        )
      ],
    );
  }
}
