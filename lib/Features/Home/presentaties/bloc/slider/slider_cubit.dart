import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:khalesi/Features/Home/data/model/model_all.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState(status: Sliderloading()));

  fetchDataSlider({required int start}) async {
    try {
      emit(SliderState(status: Sliderloading()));
      var response = await Dio()
          .get("https://alkhalissi.org/api/news?start=$start&limit=20");

      if (response.statusCode == 200) {
        print(response.data);
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
