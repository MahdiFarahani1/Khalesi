part of 'slider_cubit.dart';

class SliderState {
  final StatusSlider status;

  SliderState({required this.status});
}

abstract class StatusSlider {}

class Sliderloading extends StatusSlider {}

class Slidererror extends StatusSlider {}

class SliderComplete extends StatusSlider {
  final List<NewsGet> data;
  SliderComplete({required this.data});
}
