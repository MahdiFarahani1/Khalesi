import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Pdf/data/model/model.dart';

class DataPdfSource {
  static fetchData(
      {required int start,
      required PagingController pagingController1,
      required BuildContext context}) async {
    try {
      String url = "https://alkhalissi.org/api/book";

      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<PdfModel> newsModel =
            newsList.map((json) => PdfModel.fromJson(json)).toList();
        print(response.data);

        pagingController1.appendLastPage(newsModel);
      }
    } catch (e) {
      pagingController1.error = e;
    }
  }
}
