import 'package:flutter/material.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';

class DrawerItem {
  static Widget item({required String path, required String txt}) {
    return GestureDetector(
      onTap: () {
        print("fuck");
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 9),
        child: Row(
          children: [
            EsaySize.gap(15),
            Image(
              image: AssetImage(path),
              width: 40,
              height: 40,
            ),
            EsaySize.gap(6),
            Container(
              width: 26,
              height: 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ConstColor.yellow),
                  borderRadius: BorderRadius.circular(6)),
            ),
            EsaySize.gap(6),
            Text(
              txt,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  static Widget allItems(BuildContext context) {
    return Column(
      children: [
        Container(
          width: EsaySize.width(context) * 1.5,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image(
              image: AssetImage(Assets.images.logo.path),
            ),
          ),
        ),
        Container(
          width: EsaySize.width(context) * 1.5,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: ConstColor.yellow)),
        ),
        EsaySize.safeGap(20),
        item(path: Assets.images.home.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.book.path, txt: "الصفحه"),
        item(path: Assets.images.voice.path, txt: "الصفحه"),
        item(path: Assets.images.video.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.soal.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.bookmark.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.infoBookmark.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.share.path, txt: "الصفحه الرییسیه"),
        item(path: Assets.images.setting.path, txt: "الصفحه الرییسیه"),
      ],
    );
  }
}
