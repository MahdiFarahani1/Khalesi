import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(status: InitSearch()));

  fetchData(
      {required int start,
      required PagingController pagingController1,
      required BuildContext context,
      required String sw,
      required int title,
      required int content,
      required String mode}) async {
    try {
      emit(SearchState(status: LoadingSearch()));
      String url =
          "https://alkhalissi.org/api/$mode?start=$start&limit=20&sw=$sw&sctitle=$title&sctxt=$content";

      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();
        emit(SearchState(status: CompleteSearch()));

        // if (newsModel.isEmpty) {
        //   pagingController1.appendLastPage(newsModel);
        // } else {
        pagingController1.refresh();
        pagingController1.appendPage(newsModel, start + 20);
        // }
      }
    } catch (e) {
      print(e);
      emit(SearchState(status: ErrorSearch()));
    }
  }
}
