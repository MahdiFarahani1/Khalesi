part of 'home_main_cubit.dart';

class HomeMainState {
  final HomeStatus status;

  HomeMainState({required this.status});
}

abstract class HomeStatus {}

class News extends HomeStatus {}

class Speech extends HomeStatus {}

class Sermon extends HomeStatus {}

class Article extends HomeStatus {}
