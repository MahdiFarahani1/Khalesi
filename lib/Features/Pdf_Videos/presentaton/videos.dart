import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/utils/aboutus_repository.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Features/Pdf_Videos/data/model/model_videos.dart';
import 'package:khalesi/Features/Pdf_Videos/data/source/fetch_data_videos.dart';

class VideosPage extends StatefulWidget {
  static const String rn = "VideosPage";
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final PagingController<int, VideosModel> pagingController1 =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    pagingController1.addPageRequestListener((pageKey) {
      DataVideosSource.fetchData(
          pagingController1: pagingController1, context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context),
        drawer: CommonDrawer.drawer(context),
        body: PagedListView<int, VideosModel>(
          builderDelegate: PagedChildBuilderDelegate<VideosModel>(
            firstPageProgressIndicatorBuilder: (context) {
              return CostumLoading.fadingCircle(context);
            },
            itemBuilder: (context, item, index) {
              return GestureDetector(
                onTap: () {
                  AboutRepository.launchUrl(item.video_url!);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: EsaySize.width(context),
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
                  height: 120,
                  child: Column(
                    children: [
                      InkResponse(
                        onTap: () {
                          AboutRepository.launchUrl(item.video_url!);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.3,
                              color: ConstColor.blue,
                            ),
                            shape: BoxShape.circle,
                            color: ConstColor.yellow,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.youtube,
                            color: Colors.white,
                            size: 25,
                          ),
                        ).animate().fade(duration: const Duration(seconds: 2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title!,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          pagingController: pagingController1,
        ),
      ),
    );
  }
}
