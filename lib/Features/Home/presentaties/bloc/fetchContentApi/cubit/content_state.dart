part of 'content_cubit.dart';

class ContentState {
  dynamic data;
  late StatusClickNews status;
  ContentState({this.data, required this.status});
}

abstract class StatusClickNews {}

class ClickLoading extends StatusClickNews {}

class ClickError extends StatusClickNews {}

class ClickComplete extends StatusClickNews {}
