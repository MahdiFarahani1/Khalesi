import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/const/const_link.dart';
import 'package:khalesi/Core/extensions/layout_ex.dart';
import 'package:khalesi/Core/extensions/variyable_ex.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Core/widgets/navbar.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';
import 'package:khalesi/Features/Home/data/source/fetchData.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/indicator/indicator_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/slider/slider_cubit.dart';
import 'package:khalesi/Features/Home/presentaties/click_page.dart';
import 'package:khalesi/Features/Home/presentaties/widgets/news_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomePage extends StatefulWidget {
  static const String rn = "/homemain";
  final PagingController<int, NewsGet> pagingController1 =
      PagingController(firstPageKey: 0);

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<SliderCubit>(context)
        .fetchDataSlider(start: 0, context: context);

    widget.pagingController1.addPageRequestListener((page) {
      DataHomeSource.fetchData(
          start: page,
          pagingController1: widget.pagingController1,
          context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CommonDrawer.drawer(context),
        appBar: CommonAppbar.appBar(context),
        bottomNavigationBar: CommonNavbar.botNav(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClickPage(
                                  categoryTitle: data[index].categoryTitle!,
                                  id: data[index].id!,
                                ),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 4, left: 6, right: 6),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${ConstLink.imgBasehigh}${data[index].img!}",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return const Center(
                                        child: Icon(Icons.error));
                                  },
                                  placeholder: (context, url) {
                                    return Center(
                                        child:
                                            CostumLoading.loadCircle(context));
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 4, left: 6, right: 6),
                                height: 62,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent.withAlpha(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: ConstColor.yellow,
                                    direction: ShimmerDirection.rtl,
                                    period: const Duration(milliseconds: 2000),
                                    child: Text(
                                      data[index].title!.scableTitle(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
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
                          catgoryTitle: item.categoryTitle!,
                          id: item.id!,
                          path: "${ConstLink.imgBaselow}${item.img!}",
                          title: item.title!.scableTitle(),
                          time: item.dateTime!,
                        ).animate(autoPlay: true).moveX(
                            delay: Duration(milliseconds: 300 + index),
                            duration: const Duration(milliseconds: 300),
                            begin: -500,
                            end: 0);
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
