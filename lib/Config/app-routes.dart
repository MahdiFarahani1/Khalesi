import 'package:flutter/material.dart';
import 'package:khalesi/Features/About_Us/presentations/screens/about_us_page.dart';
import 'package:khalesi/Features/Home/presentaties/home_main.dart';
import 'package:khalesi/Features/Pdf_Videos/presentaton/pdf.dart';
import 'package:khalesi/Features/Pdf_Videos/presentaton/videos.dart';
import 'package:khalesi/Features/Save/presentation/view_save.dart';
import 'package:khalesi/Features/Search/presententaion/search_page.dart';
import 'package:khalesi/Features/questions/presntations/ques.dart';

class RoutesApp {
  static Map<String, Widget Function(BuildContext)> routes = {
    MyHomePage.rn: (p0) => MyHomePage(),
    SearchPage.rn: (p0) => const SearchPage(),
    PdfPage.rn: (p0) => const PdfPage(),
    AboutUs.rn: (p0) => const AboutUs(),
    SavePage.rn: (p0) => const SavePage(),
    VideosPage.rn: (p0) => const VideosPage(),
    QuesPage.rn: (p0) => const QuesPage(),
  };
}
