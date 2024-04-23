import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/const/const_link.dart';
import 'package:khalesi/Core/extensions/layout_ex.dart';
import 'package:khalesi/Core/extensions/variyable_ex.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/indicator/indicator_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/navbar/nav_bar_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/slider/slider_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/widgets/news_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomePage extends StatefulWidget {
  final PagingController<int, NewsGet> pagingController1 =
      PagingController(firstPageKey: 0);

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    widget.pagingController1.addPageRequestListener((page) {
      fetchData(start: page);

      BlocProvider.of<SliderCubit>(context).fetchDataSlider(start: page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(context),
        bottomNavigationBar: botNav(),
        body: Column(
          children: [
            BlocBuilder<SliderCubit, SliderState>(
              builder: (context, state) {
                if (state.status is Sliderloading) {
                  return Expanded(
                    child: CostumLoading.loadLine(context),
                  );
                }
                if (state.status is SliderComplete) {
                  var data = (state.status as SliderComplete).data;
                  return CarouselSlider.builder(
                    itemCount: 4,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.only(
                            left: 9, top: 10, bottom: 4, right: 9),
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: "${ConstLink.imgBase}${data[index].img!}",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Expanded(child: Icon(Icons.error));
                          },
                          placeholder: (context, url) {
                            return Expanded(
                                child: CostumLoading.loadCircle(context));
                          },
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        BlocProvider.of<IndicatorCubit>(context)
                            .changeState(index);
                      },
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                    ),
                  );
                }
                return const Icon(Icons.error);
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              alignment: Alignment.center,
              height: 25,
              width: EsaySize.width(context) / 3.2,
              child: BlocBuilder<IndicatorCubit, IndicatorState>(
                builder: (context, state) {
                  return AnimatedSmoothIndicator(
                      effect: ExpandingDotsEffect(
                        dotWidth: 12,
                        dotHeight: 4,
                        dotColor: ConstColor.blue,
                        activeDotColor: ConstColor.yellow,
                      ),
                      activeIndex: state.index,
                      count: 4);
                },
              ),
            ),
            Expanded(
                child: PagedListView<int, NewsGet>(
                    pagingController: widget.pagingController1,
                    builderDelegate: PagedChildBuilderDelegate(
                      newPageProgressIndicatorBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CostumLoading.fadingCircle(context),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return CostumLoading.fadingCircle(context);
                      },
                      noMoreItemsIndicatorBuilder: (context) {
                        return Container(
                          alignment: Alignment.center,
                          margin: 10.0.padAllConst(),
                          width: EsaySize.width(context),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ConstColor.yellow),
                          child: const Text("تم الانتهاء من عناصر القائمة"),
                        );
                      },
                      itemBuilder: (context, item, index) {
                        return NewsItem(
                          id: item.id!,
                          path: "${ConstLink.imgBase}${item.img!}",
                          title: item.title!.scableTitle(),
                          time: item.dateTime!,
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }

  fetchData({required int start}) async {
    try {
      var response = await Dio()
          .get("https://alkhalissi.org/api/news?start=$start&limit=20");

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();

        if (newsModel.isEmpty) {
          widget.pagingController1.appendLastPage(newsModel);
        } else {
          widget.pagingController1.appendPage(newsModel, start + 20);
        }
      }
    } catch (e) {
      widget.pagingController1.error = e;

      print(e);
    }
  }

  Widget botNav() {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return FlashyTabBar(
          backgroundColor: ConstColor.blue,
          selectedIndex: state.index,
          showElevation: true,
          onItemSelected: (value) {
            BlocProvider.of<NavBarCubit>(context).changeState(value);
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

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.blue,
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.8, color: Colors.white)),
                  child: Icon(
                    FontAwesomeIcons.barsStaggered,
                    size: 25,
                    color: ConstColor.yellow,
                  ),
                ),
              ),
              Assets.images.logo.image(
                  fit: BoxFit.contain,
                  width: EsaySize.width(context) / 2,
                  height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Transform.rotate(
                  angle: 90 * 3.14159265359 / 180,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.8, color: Colors.white)),
                    child: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 25,
                      color: ConstColor.yellow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
