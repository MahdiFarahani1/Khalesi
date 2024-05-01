import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Audio/data/model/model_audio.dart';

class DataAudioSource {
  static fetchData(
      {required PagingController pagingController1,
      required BuildContext context,
      required int catId}) async {
    try {
      String url = "https://alkhalissi.org/api/Sounds?category=$catId";

      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['sounds'];
        List<AudioModel> newsModel =
            newsList.map((json) => AudioModel.fromJson(json)).toList();

        pagingController1.appendLastPage(newsModel);
      }
    } catch (e) {
      pagingController1.error = e;
    }
  }
}
