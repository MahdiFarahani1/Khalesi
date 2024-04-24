import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';

class DataHomeSource {
  static fetchData(
      {required int start,
      required PagingController pagingController1,
      required BuildContext context}) async {
    try {
      String url = "";

      switch (BlocProvider.of<HomeMainCubit>(context).state.status) {
        case News():
          url = "https://alkhalissi.org/api/news?start=$start&limit=20";
          break;
        case Speech():
          url = "https://alkhalissi.org/api/speech?start=$start&limit=20";
          break;
        case Sermon():
          url = "https://alkhalissi.org/api/sermon?start=$start&limit=20";
          break;
        case Article():
          url = "https://alkhalissi.org/api/article?start=$start&limit=20";
          break;
        default:
      }
      var response = await Dio().get(url);

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
