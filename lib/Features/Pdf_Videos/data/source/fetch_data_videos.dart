import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Pdf_Videos/data/model/model_videos.dart';

class DataVideosSource {
  static fetchData(
      {required PagingController pagingController1,
      required BuildContext context}) async {
    try {
      String url = "https://alkhalissi.org/api/Videos";

      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['videos'];
        List<VideosModel> newsModel =
            newsList.map((json) => VideosModel.fromJson(json)).toList();

        pagingController1.appendLastPage(newsModel);
      }
    } catch (e) {
      pagingController1.error = e;
    }
  }
}
