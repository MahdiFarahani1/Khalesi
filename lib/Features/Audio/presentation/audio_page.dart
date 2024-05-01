import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Features/Audio/data/model/model_audio.dart';
import 'package:khalesi/Features/Audio/data/source/fetch_audio.dart';
import 'package:khalesi/Features/Audio/presentation/audio_click.dart';

class AudioPage extends StatefulWidget {
  static const rn = "/audioPage";
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  int selectedIndex = 0;
  final PagingController<int, AudioModel> pagingController1 =
      PagingController(firstPageKey: 0);
  Map<int, String> category = {
    22: "الفقة",
    23: "خطب الجمعة",
    24: "المحاضرات",
    25: "اللقاءات",
  };
  @override
  void initState() {
    super.initState();
    DataAudioSource.fetchData(
        pagingController1: pagingController1, context: context, catId: 22);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CommonAppbar.appBar(context),
          drawer: CommonDrawer.drawer(context),
          body: Column(
            children: [
              SizedBox(
                width: EsaySize.width(context),
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex = index;
                        pagingController1.refresh();
                        DataAudioSource.fetchData(
                            pagingController1: pagingController1,
                            context: context,
                            catId: category.keys.toList()[index]);
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: selectedIndex == index
                              ? ConstColor.yellow
                              : ConstColor.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.values.toList()[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              PagedListView(
                  shrinkWrap: true,
                  pagingController: pagingController1,
                  builderDelegate: PagedChildBuilderDelegate<AudioModel>(
                    firstPageErrorIndicatorBuilder: (context) {
                      return const SizedBox.shrink();
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: EsaySize.width(context) * 0.7),
                        child: Center(
                          child: CostumLoading.fadingCircle(context),
                        ),
                      );
                    },
                    itemBuilder: (context, item, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: EsaySize.width(context),
                        height: EsaySize.height(context) * 0.1,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: EsaySize.width(context) * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(item.title!),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AudioClick(
                                            title: item.title!,
                                            urlAudio: item.soundUrl!,
                                          ),
                                        ));
                                  },
                                  icon: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: ConstColor.blue,
                                              width: 2.5)),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: ConstColor.blue,
                                        size: 30,
                                      ))),
                            )
                          ],
                        ),
                      );
                    },
                  ))
            ],
          ),
        ));
  }
}
