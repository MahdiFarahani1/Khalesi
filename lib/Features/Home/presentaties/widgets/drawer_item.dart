import 'package:flutter/material.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Features/About_Us/presentations/screens/about_us_page.dart';
import 'package:khalesi/Features/Audio/presentation/audio_page.dart';
import 'package:khalesi/Features/Home/presentaties/home_main.dart';
import 'package:khalesi/Features/Pdf_Videos/presentaton/pdf.dart';
import 'package:khalesi/Features/Pdf_Videos/presentaton/videos.dart';
import 'package:khalesi/Features/Save/presentation/view_save.dart';
import 'package:khalesi/Features/Settings/presentation/setting.dart';
import 'package:khalesi/Features/questions/presntations/ques.dart';
import 'package:share_plus/share_plus.dart';

class DrawerItem {
  static Widget item(
      {required String path,
      required String txt,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
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
        SizedBox(
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
        item(
          path: Assets.images.home.path,
          txt: "الصفحة الرئيسية",
          onTap: () {
            Navigator.pushNamed(context, MyHomePage.rn);
          },
        ),
        item(
          path: Assets.images.book.path,
          txt: "المكتبة",
          onTap: () {
            Navigator.pushNamed(context, PdfPage.rn);
          },
        ),
        item(
          path: Assets.images.voice.path,
          txt: "الصوتيات",
          onTap: () {
            Navigator.pushNamed(context, AudioPage.rn);
          },
        ),
        item(
          path: Assets.images.video.path,
          txt: " المرئيات",
          onTap: () {
            Navigator.pushNamed(context, VideosPage.rn);
          },
        ),
        item(
          path: Assets.images.soal.path,
          txt: "الاسئلة",
          onTap: () {
            Navigator.pushNamed(context, QuesPage.rn);
          },
        ),
        item(
          path: Assets.images.bookmark.path,
          txt: "المفضلة",
          onTap: () {
            Navigator.pushNamed(context, SavePage.rn);
          },
        ),
        item(
          path: Assets.images.infoBookmark.path,
          txt: "حول التطبيق",
          onTap: () {
            Navigator.pushNamed(context, AboutUs.rn);
          },
        ),
        item(
          path: Assets.images.share.path,
          txt: "مشاركة التطبيق",
          onTap: () {
            Share.share(
                "https://play.google.com/store/apps/details?id=com.dijlah.alkhalissi");
          },
        ),
        item(
          path: Assets.images.setting.path,
          txt: "الاعدادات",
          onTap: () {
            Navigator.pushNamed(context, SettingPage.rn);
          },
        ),
      ],
    );
  }
}
