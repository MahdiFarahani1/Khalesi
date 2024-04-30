import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/questions/data/model/ques_model.dart';

class DataQuestSource {
  static fetchData(
      {required PagingController pagingController1,
      required BuildContext context}) async {
    try {
      String url = "https://alkhalissi.org/api/Questions";

      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['questions'];
        print(response.data);
        List<QuestionsModel> newsModel =
            newsList.map((json) => QuestionsModel.fromJson(json)).toList();

        pagingController1.appendLastPage(newsModel);
      }
    } catch (e) {
      pagingController1.error = e;
    }
  }
}
