import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';
import 'package:khalesi/Features/Home/presentaties/bloc/home_main/home_main_cubit.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState(status: Sliderloading()));

  fetchDataSlider({required int start, required BuildContext context}) async {
    try {
      emit(SliderState(status: Sliderloading()));
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

        emit(SliderState(status: SliderComplete(data: newsModel)));
      }
    } catch (e) {
      emit(SliderState(status: Slidererror()));

      print(e);
    }
  }
}
