part of 'search_cubit.dart';

class SearchState {
  final SearchStatus status;

  SearchState({required this.status});
}

abstract class SearchStatus {}

class LoadingSearch extends SearchStatus {}

class ErrorSearch extends SearchStatus {}

class CompleteSearch extends SearchStatus {}

class InitSearch extends SearchStatus {}
