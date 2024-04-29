import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/fetchContentApi/model/content_model.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentState(status: ClickLoading()));

  fetchData({required int id, required BuildContext context}) async {
    try {
      emit(ContentState(status: ClickLoading()));
      String url = "";
      switch (BlocProvider.of<HomeMainCubit>(context).state.status) {
        case News():
          url = "https://alkhalissi.org/api/news/content/$id";
          break;
        case Speech():
          url = "https://alkhalissi.org/api/speech/content/$id";
          break;
        case Sermon():
          url = "https://alkhalissi.org/api/sermon/content/$id";
          break;
        case Article():
          url = "https://alkhalissi.org/api/article/content/$id";

          break;
        default:
      }
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        var newsModel = ContentModel.fromJson(response.data);

        emit(ContentState(status: ClickComplete(), data: newsModel));
      } else {
        emit(ContentState(
          status: ClickError(),
        ));
      }
    } catch (e) {
      emit(ContentState(
        status: ClickError(),
      ));
    }
  }

  fetchDataSave(
      {required int id,
      required BuildContext context,
      required String categoryTitle}) async {
    try {
      emit(ContentState(status: ClickLoading()));
      String url = "";
      switch (categoryTitle) {
        case "اخبار ونشاطات":
          url = "https://alkhalissi.org/api/news/content/$id";
          break;
        case "البيانات الرسمية":
          url = "https://alkhalissi.org/api/speech/content/$id";
          break;
        case "تصنيف الاول":
          url = "https://alkhalissi.org/api/sermon/content/$id";
          break;
        case "مقالات مختارة":
          url = "https://alkhalissi.org/api/article/content/$id";

          break;
        default:
      }
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        var newsModel = ContentModel.fromJson(response.data);

        emit(ContentState(status: ClickComplete(), data: newsModel));
      } else {
        emit(ContentState(
          status: ClickError(),
        ));
      }
    } catch (e) {
      emit(ContentState(
        status: ClickError(),
      ));
    }
  }
}
