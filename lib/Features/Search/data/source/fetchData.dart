import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';

class DataSearchSource {
  static fetchData(
      {required int start,
      required PagingController pagingController1,
      required BuildContext context,
      required String sw,
      required int title,
      required int content,
      required String mode}) async {
    try {
      String url =
          "https://alkhalissi.org/api/$mode?start=$start&limit=20&sw=$sw&sctitle=$title&sctxt=$content";

      var response = await Dio().get(url);
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();

        if (newsModel.isEmpty) {
          pagingController1.appendLastPage(newsModel);
        } else {
          pagingController1.appendPage(newsModel, start + 20);
        }
      }
    } catch (e) {
      pagingController1.error = e;
    }
  }
}
