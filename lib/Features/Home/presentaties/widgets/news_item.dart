import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Core/const/const_Color.dart';

import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Features/Home/presentaties/click_page.dart';

class NewsItem extends StatelessWidget {
  final String path;
  final String title;
  final String time;
  final int id;
  final String catgoryTitle;
  final bool isSaveMode;
  const NewsItem(
      {super.key,
      this.isSaveMode = false,
      required this.path,
      required this.title,
      required this.time,
      required this.id,
      required this.catgoryTitle});

  @override
  Widget build(BuildContext context) {
    var checkTheme = saveAll.get("islightmode") ??
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClickPage(
                isSaveMode: isSaveMode,
                categoryTitle: catgoryTitle,
                id: id,
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 1,
                blurRadius: checkTheme ? 5 : 1,
                offset: checkTheme ? const Offset(0, 5) : const Offset(0, 1),
              ),
              // BoxShadow(
              //   color: Colors.grey.shade300,
              //   offset: const Offset(-5, 0),
              // )
            ],
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor),
        width: EsaySize.width(context),
        height: EsaySize.height(context) / 7.2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: SizedBox(
                width: EsaySize.width(context) / 3.2,
                height: EsaySize.height(context) / 7.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: path,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                    placeholder: (context, url) {
                      return Center(
                        child: CostumLoading.loadCircle(context),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    right: EsaySize.width(context) / 3, left: 8, top: 8),
                child: Text(
                  title,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: ConstColor.yellow,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
